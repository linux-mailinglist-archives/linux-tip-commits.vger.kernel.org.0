Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483E43E9198
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Aug 2021 14:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhHKMhS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Aug 2021 08:37:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51344 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhHKMhM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Aug 2021 08:37:12 -0400
Date:   Wed, 11 Aug 2021 12:36:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628685407;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wF82md4Nq1VZDwGhMR4wES9PnEtCYTeN4sEd3EzuvG8=;
        b=V+CCjceMZknuK5fTh3aszAhFSh60ULfj7lmnpq3YlVGnXSRivVmXn8UhyuCLMRJuMryMEf
        FjSfSxqbCw7kLtnOJhSraMadARWlaa9agF27Dza958L7MGgwlptmtZqSUCeOI8E3OVap+j
        gWM6BwdaXDbHDpKvcZCfy8GakFvVw7BQKSYXV6v3I6npf7uxVwGVRHm/GQXlJKdu+OQUwx
        kvk166iS+SkuEptQ4I7GKSmMueq5zXx92egpjfMe8/NCpQ05px+ERNzKDTW0YNZ0eQsv0E
        jKRQZP29HwaX59ZjdgKrA7TLKoB9B/6NnGWvmlw5l12DgpQUXrFkK9Q+mg6MBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628685407;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wF82md4Nq1VZDwGhMR4wES9PnEtCYTeN4sEd3EzuvG8=;
        b=q0zWjN1k88G9jz4ZQXnE61uP6KtseHFMhbqdTwQZ5q38HxXnmET6KJH2dHOLgG38giNYUy
        /TquoMeLBGfnZKCw==
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Fix kernel-doc warnings in pm.c, msi.c and ipi.c
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210810234835.12547-1-rdunlap@infradead.org>
References: <20210810234835.12547-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID: <162868540660.395.3394935014471208938.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     3b35e7e6daef5a8b4819e2bd2d15898b9b4d1669
Gitweb:        https://git.kernel.org/tip/3b35e7e6daef5a8b4819e2bd2d15898b9b4d1669
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Tue, 10 Aug 2021 16:48:35 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 11 Aug 2021 14:33:35 +02:00

genirq: Fix kernel-doc warnings in pm.c, msi.c and ipi.c

Fix all kernel-doc warnings in these 3 files and do some simple editing
(capitalize acronyms, capitalize Linux).

kernel/irq/pm.c:235: warning: expecting prototype for irq_pm_syscore_ops(). Prototype was for irq_pm_syscore_resume() instead
kernel/irq/msi.c:530: warning: expecting prototype for __msi_domain_free_irqs(). Prototype was for msi_domain_free_irqs() instead
kernel/irq/msi.c:31: warning: No description found for return value of 'alloc_msi_entry'
kernel/irq/msi.c:103: warning: No description found for return value of 'msi_domain_set_affinity'
kernel/irq/msi.c:288: warning: No description found for return value of 'msi_create_irq_domain'
kernel/irq/msi.c:499: warning: No description found for return value of 'msi_domain_alloc_irqs'
kernel/irq/msi.c:545: warning: No description found for return value of 'msi_get_domain_info'
kernel/irq/ipi.c:264: warning: expecting prototype for ipi_send_mask(). Prototype was for __ipi_send_mask() instead
kernel/irq/ipi.c:25: warning: No description found for return value of 'irq_reserve_ipi'
kernel/irq/ipi.c:116: warning: No description found for return value of 'irq_destroy_ipi'
kernel/irq/ipi.c:163: warning: No description found for return value of 'ipi_get_hwirq'
kernel/irq/ipi.c:222: warning: No description found for return value of '__ipi_send_single'
kernel/irq/ipi.c:308: warning: No description found for return value of 'ipi_send_single'
kernel/irq/ipi.c:329: warning: No description found for return value of 'ipi_send_mask'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210810234835.12547-1-rdunlap@infradead.org

---
 kernel/irq/ipi.c | 32 ++++++++++++++++----------------
 kernel/irq/msi.c | 19 ++++++++++++-------
 kernel/irq/pm.c  |  2 +-
 3 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/kernel/irq/ipi.c b/kernel/irq/ipi.c
index 52f11c7..08ce7da 100644
--- a/kernel/irq/ipi.c
+++ b/kernel/irq/ipi.c
@@ -14,11 +14,11 @@
 /**
  * irq_reserve_ipi() - Setup an IPI to destination cpumask
  * @domain:	IPI domain
- * @dest:	cpumask of cpus which can receive the IPI
+ * @dest:	cpumask of CPUs which can receive the IPI
  *
  * Allocate a virq that can be used to send IPI to any CPU in dest mask.
  *
- * On success it'll return linux irq number and error code on failure
+ * Return: Linux IRQ number on success or error code on failure
  */
 int irq_reserve_ipi(struct irq_domain *domain,
 			     const struct cpumask *dest)
@@ -104,13 +104,13 @@ free_descs:
 
 /**
  * irq_destroy_ipi() - unreserve an IPI that was previously allocated
- * @irq:	linux irq number to be destroyed
- * @dest:	cpumask of cpus which should have the IPI removed
+ * @irq:	Linux IRQ number to be destroyed
+ * @dest:	cpumask of CPUs which should have the IPI removed
  *
  * The IPIs allocated with irq_reserve_ipi() are returned to the system
  * destroying all virqs associated with them.
  *
- * Return 0 on success or error code on failure.
+ * Return: %0 on success or error code on failure.
  */
 int irq_destroy_ipi(unsigned int irq, const struct cpumask *dest)
 {
@@ -150,14 +150,14 @@ int irq_destroy_ipi(unsigned int irq, const struct cpumask *dest)
 }
 
 /**
- * ipi_get_hwirq - Get the hwirq associated with an IPI to a cpu
- * @irq:	linux irq number
- * @cpu:	the target cpu
+ * ipi_get_hwirq - Get the hwirq associated with an IPI to a CPU
+ * @irq:	Linux IRQ number
+ * @cpu:	the target CPU
  *
  * When dealing with coprocessors IPI, we need to inform the coprocessor of
  * the hwirq it needs to use to receive and send IPIs.
  *
- * Returns hwirq value on success and INVALID_HWIRQ on failure.
+ * Return: hwirq value on success or INVALID_HWIRQ on failure.
  */
 irq_hw_number_t ipi_get_hwirq(unsigned int irq, unsigned int cpu)
 {
@@ -216,7 +216,7 @@ static int ipi_send_verify(struct irq_chip *chip, struct irq_data *data,
  * This function is for architecture or core code to speed up IPI sending. Not
  * usable from driver code.
  *
- * Returns zero on success and negative error number on failure.
+ * Return: %0 on success or negative error number on failure.
  */
 int __ipi_send_single(struct irq_desc *desc, unsigned int cpu)
 {
@@ -250,7 +250,7 @@ int __ipi_send_single(struct irq_desc *desc, unsigned int cpu)
 }
 
 /**
- * ipi_send_mask - send an IPI to target Linux SMP CPU(s)
+ * __ipi_send_mask - send an IPI to target Linux SMP CPU(s)
  * @desc:	pointer to irq_desc of the IRQ
  * @dest:	dest CPU(s), must be a subset of the mask passed to
  *		irq_reserve_ipi()
@@ -258,7 +258,7 @@ int __ipi_send_single(struct irq_desc *desc, unsigned int cpu)
  * This function is for architecture or core code to speed up IPI sending. Not
  * usable from driver code.
  *
- * Returns zero on success and negative error number on failure.
+ * Return: %0 on success or negative error number on failure.
  */
 int __ipi_send_mask(struct irq_desc *desc, const struct cpumask *dest)
 {
@@ -298,11 +298,11 @@ int __ipi_send_mask(struct irq_desc *desc, const struct cpumask *dest)
 
 /**
  * ipi_send_single - Send an IPI to a single CPU
- * @virq:	linux irq number from irq_reserve_ipi()
+ * @virq:	Linux IRQ number from irq_reserve_ipi()
  * @cpu:	destination CPU, must in the destination mask passed to
  *		irq_reserve_ipi()
  *
- * Returns zero on success and negative error number on failure.
+ * Return: %0 on success or negative error number on failure.
  */
 int ipi_send_single(unsigned int virq, unsigned int cpu)
 {
@@ -319,11 +319,11 @@ EXPORT_SYMBOL_GPL(ipi_send_single);
 
 /**
  * ipi_send_mask - Send an IPI to target CPU(s)
- * @virq:	linux irq number from irq_reserve_ipi()
+ * @virq:	Linux IRQ number from irq_reserve_ipi()
  * @dest:	dest CPU(s), must be a subset of the mask passed to
  *		irq_reserve_ipi()
  *
- * Returns zero on success and negative error number on failure.
+ * Return: %0 on success or negative error number on failure.
  */
 int ipi_send_mask(unsigned int virq, const struct cpumask *dest)
 {
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index c41965e..bb18040 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -18,13 +18,15 @@
 #include "internals.h"
 
 /**
- * alloc_msi_entry - Allocate an initialize msi_entry
+ * alloc_msi_entry - Allocate an initialized msi_desc
  * @dev:	Pointer to the device for which this is allocated
  * @nvec:	The number of vectors used in this entry
  * @affinity:	Optional pointer to an affinity mask array size of @nvec
  *
- * If @affinity is not NULL then an affinity array[@nvec] is allocated
+ * If @affinity is not %NULL then an affinity array[@nvec] is allocated
  * and the affinity masks and flags from @affinity are copied.
+ *
+ * Return: pointer to allocated &msi_desc on success or %NULL on failure
  */
 struct msi_desc *alloc_msi_entry(struct device *dev, int nvec,
 				 const struct irq_affinity_desc *affinity)
@@ -97,6 +99,8 @@ static void msi_check_level(struct irq_domain *domain, struct msi_msg *msg)
  *
  * Intended to be used by MSI interrupt controllers which are
  * implemented with hierarchical domains.
+ *
+ * Return: IRQ_SET_MASK_* result code
  */
 int msi_domain_set_affinity(struct irq_data *irq_data,
 			    const struct cpumask *mask, bool force)
@@ -277,10 +281,12 @@ static void msi_domain_update_chip_ops(struct msi_domain_info *info)
 }
 
 /**
- * msi_create_irq_domain - Create a MSI interrupt domain
+ * msi_create_irq_domain - Create an MSI interrupt domain
  * @fwnode:	Optional fwnode of the interrupt controller
  * @info:	MSI domain info
  * @parent:	Parent irq domain
+ *
+ * Return: pointer to the created &struct irq_domain or %NULL on failure
  */
 struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 					 struct msi_domain_info *info,
@@ -492,7 +498,7 @@ cleanup:
  *		are allocated
  * @nvec:	The number of interrupts to allocate
  *
- * Returns 0 on success or an error code.
+ * Return: %0 on success or an error code.
  */
 int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 			  int nvec)
@@ -521,7 +527,7 @@ void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
 }
 
 /**
- * __msi_domain_free_irqs - Free interrupts from a MSI interrupt @domain associated tp @dev
+ * msi_domain_free_irqs - Free interrupts from a MSI interrupt @domain associated to @dev
  * @domain:	The domain to managing the interrupts
  * @dev:	Pointer to device struct of the device for which the interrupts
  *		are free
@@ -538,8 +544,7 @@ void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
  * msi_get_domain_info - Get the MSI interrupt domain info for @domain
  * @domain:	The interrupt domain to retrieve data from
  *
- * Returns the pointer to the msi_domain_info stored in
- * @domain->host_data.
+ * Return: the pointer to the msi_domain_info stored in @domain->host_data.
  */
 struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain)
 {
diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index ce0adb2..ca71123 100644
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -227,7 +227,7 @@ unlock:
 }
 
 /**
- * irq_pm_syscore_ops - enable interrupt lines early
+ * irq_pm_syscore_resume - enable interrupt lines early
  *
  * Enable all interrupt lines with %IRQF_EARLY_RESUME set.
  */
