import 'package:flutter/material.dart';
import 'package:pedido_app/domain/entities/order.dart';
import 'package:pedido_app/core/constants/app_constants.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback? onTap;
  final VoidCallback? onStatusTap;

  const OrderCard({
    super.key,
    required this.order,
    this.onTap,
    this.onStatusTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, colorScheme),
              const SizedBox(height: 12),
              _buildOrderInfo(context),
              const SizedBox(height: 12),
              _buildItemsPreview(context),
              const SizedBox(height: 12),
              _buildFooter(context, colorScheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Pedido #${order.id.substring(0, 8).toUpperCase()}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        _StatusChip(
          status: order.status,
          onTap: onStatusTap,
        ),
      ],
    );
  }

  Widget _buildOrderInfo(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.calendar_today,
          size: 16,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 4),
        Text(
          _formatDate(order.date),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(width: 16),
        Icon(
          Icons.shopping_bag_outlined,
          size: 16,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 4),
        Text(
          '${order.items.length} ${order.items.length == 1 ? 'producto' : 'productos'}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }

  Widget _buildItemsPreview(BuildContext context) {
    final displayItems = order.items.take(3).toList();
    final remainingCount = order.items.length - 3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...displayItems.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        '${item.quantity}',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item.productName,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '\$${item.unitPrice.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            )),
        if (remainingCount > 0)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              '+$remainingCount ${remainingCount == 1 ? 'producto más' : 'productos más'}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
              ),
              Text(
                '\$${order.calculatedTotal.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                _getPaymentIcon(order.paymentMethod),
                size: 20,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Text(
                _formatPaymentMethod(order.paymentMethod),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Hoy';
    } else if (difference.inDays == 1) {
      return 'Ayer';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} días atrás';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  String _formatPaymentMethod(String method) {
    switch (method) {
      case PaymentMethod.creditCard:
        return 'Tarjeta de crédito';
      case PaymentMethod.debitCard:
        return 'Tarjeta de débito';
      case PaymentMethod.cash:
        return 'Efectivo';
      case PaymentMethod.transfer:
        return 'Transferencia';
      case PaymentMethod.paypal:
        return 'PayPal';
      default:
        return method;
    }
  }

  IconData _getPaymentIcon(String method) {
    switch (method) {
      case PaymentMethod.creditCard:
      case PaymentMethod.debitCard:
        return Icons.credit_card;
      case PaymentMethod.cash:
        return Icons.money;
      case PaymentMethod.transfer:
        return Icons.account_balance;
      case PaymentMethod.paypal:
        return Icons.payment;
      default:
        return Icons.payment;
    }
  }
}

class _StatusChip extends StatelessWidget {
  final String status;
  final VoidCallback? onTap;

  const _StatusChip({
    required this.status,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final config = _getStatusConfig(status);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: config.backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              config.icon,
              size: 14,
              color: config.textColor,
            ),
            const SizedBox(width: 4),
            Text(
              config.label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: config.textColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  _StatusConfig _getStatusConfig(String status) {
    switch (status) {
      case OrderStatus.pending:
        return _StatusConfig(
          label: 'Pendiente',
          backgroundColor: Colors.orange.shade100,
          textColor: Colors.orange.shade800,
          icon: Icons.schedule,
        );
      case OrderStatus.processing:
        return _StatusConfig(
          label: 'Procesando',
          backgroundColor: Colors.blue.shade100,
          textColor: Colors.blue.shade800,
          icon: Icons.sync,
        );
      case OrderStatus.completed:
        return _StatusConfig(
          label: 'Completado',
          backgroundColor: Colors.green.shade100,
          textColor: Colors.green.shade800,
          icon: Icons.check_circle,
        );
      case OrderStatus.cancelled:
        return _StatusConfig(
          label: 'Cancelado',
          backgroundColor: Colors.red.shade100,
          textColor: Colors.red.shade800,
          icon: Icons.cancel,
        );
      case OrderStatus.failed:
        return _StatusConfig(
          label: 'Fallido',
          backgroundColor: Colors.grey.shade200,
          textColor: Colors.grey.shade700,
          icon: Icons.error,
        );
      default:
        return _StatusConfig(
          label: status,
          backgroundColor: Colors.grey.shade100,
          textColor: Colors.grey.shade700,
          icon: Icons.help_outline,
        );
    }
  }
}

class _StatusConfig {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final IconData icon;

  _StatusConfig({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    required this.icon,
  });
}