Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0D73E856C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 23:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbhHJVgK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 17:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbhHJVgH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 17:36:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE15C061765;
        Tue, 10 Aug 2021 14:35:44 -0700 (PDT)
Date:   Tue, 10 Aug 2021 21:35:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628631341;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YGhQVUZqbAzjoyKpP8UUCBukO2Ia9umsHGqPX2ZeiDU=;
        b=T8VCgLEcIEHKbd6hJ0Sjfl7cRjwW7ForDbzOnV0klBoGLlLO+2nDIO/GHaJrhvO4wVB5mE
        WQPpHB7cGzLalgoEmjeR+JD5qoyn9jzMbnUDq3S5nNRHjKntZPAerQ/uQlpUC+vHozAsq8
        xL3zCPh7B3jDsz1/+hG24LcQqryZ+9Cu8N5Y3vlOH5otmBeFbiSCyN51JpeBQsM/dWNkN9
        fMlDP6Nynopa9Q6Rdz7IKYK65aKsy706X2LDK9Z4hdmqw7qi5HXG7Fr4ab0CugNLkWINWK
        CZT1GpPLEMMNbyz7WwrhsjqDkAwMDiKuEnI7JUW77cvFXBJR4EPwaboNdiZdeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628631341;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YGhQVUZqbAzjoyKpP8UUCBukO2Ia9umsHGqPX2ZeiDU=;
        b=hD+9/wVSy+8aeL/doRjk1XSSjKqn6JXSzUHZZudBNGpppX97U+2KP0cUauHtwyvXiWrYOa
        IyWBahsf8OtUsEBw==
From:   "tip-bot2 for Maciej W. Rozycki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86: Fix typo s/ECLR/ELCR/ for the PIC register
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2107200251080.9461@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2107200251080.9461@angie.orcam.me.uk>
MIME-Version: 1.0
Message-ID: <162863134099.395.10038351399544662720.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     34739a2809e1e5d54d41d93cfc6b074e8d781ee2
Gitweb:        https://git.kernel.org/tip/34739a2809e1e5d54d41d93cfc6b074e8d781ee2
Author:        Maciej W. Rozycki <macro@orcam.me.uk>
AuthorDate:    Tue, 20 Jul 2021 05:28:15 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 23:31:44 +02:00

x86: Fix typo s/ECLR/ELCR/ for the PIC register

The proper spelling for the acronym referring to the Edge/Level Control 
Register is ELCR rather than ECLR.  Adjust references accordingly.  No 
functional change.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/alpine.DEB.2.21.2107200251080.9461@angie.orcam.me.uk

---
 arch/x86/kernel/acpi/boot.c |  6 +++---
 arch/x86/kvm/i8259.c        | 20 ++++++++++----------
 arch/x86/kvm/irq.h          |  2 +-
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 7f59f83..14bcd59 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -558,10 +558,10 @@ acpi_parse_nmi_src(union acpi_subtable_headers * header, const unsigned long end
  * If a PIC-mode SCI is not recognized or gives spurious IRQ7's
  * it may require Edge Trigger -- use "acpi_sci=edge"
  *
- * Port 0x4d0-4d1 are ECLR1 and ECLR2, the Edge/Level Control Registers
+ * Port 0x4d0-4d1 are ELCR1 and ELCR2, the Edge/Level Control Registers
  * for the 8259 PIC.  bit[n] = 1 means irq[n] is Level, otherwise Edge.
- * ECLR1 is IRQs 0-7 (IRQ 0, 1, 2 must be 0)
- * ECLR2 is IRQs 8-15 (IRQ 8, 13 must be 0)
+ * ELCR1 is IRQs 0-7 (IRQ 0, 1, 2 must be 0)
+ * ELCR2 is IRQs 8-15 (IRQ 8, 13 must be 0)
  */
 
 void __init acpi_pic_sci_set_trigger(unsigned int irq, u16 trigger)
diff --git a/arch/x86/kvm/i8259.c b/arch/x86/kvm/i8259.c
index 629a09c..0b80263 100644
--- a/arch/x86/kvm/i8259.c
+++ b/arch/x86/kvm/i8259.c
@@ -541,17 +541,17 @@ static int picdev_slave_read(struct kvm_vcpu *vcpu, struct kvm_io_device *dev,
 			    addr, len, val);
 }
 
-static int picdev_eclr_write(struct kvm_vcpu *vcpu, struct kvm_io_device *dev,
+static int picdev_elcr_write(struct kvm_vcpu *vcpu, struct kvm_io_device *dev,
 			     gpa_t addr, int len, const void *val)
 {
-	return picdev_write(container_of(dev, struct kvm_pic, dev_eclr),
+	return picdev_write(container_of(dev, struct kvm_pic, dev_elcr),
 			    addr, len, val);
 }
 
-static int picdev_eclr_read(struct kvm_vcpu *vcpu, struct kvm_io_device *dev,
+static int picdev_elcr_read(struct kvm_vcpu *vcpu, struct kvm_io_device *dev,
 			    gpa_t addr, int len, void *val)
 {
-	return picdev_read(container_of(dev, struct kvm_pic, dev_eclr),
+	return picdev_read(container_of(dev, struct kvm_pic, dev_elcr),
 			    addr, len, val);
 }
 
@@ -577,9 +577,9 @@ static const struct kvm_io_device_ops picdev_slave_ops = {
 	.write    = picdev_slave_write,
 };
 
-static const struct kvm_io_device_ops picdev_eclr_ops = {
-	.read     = picdev_eclr_read,
-	.write    = picdev_eclr_write,
+static const struct kvm_io_device_ops picdev_elcr_ops = {
+	.read     = picdev_elcr_read,
+	.write    = picdev_elcr_write,
 };
 
 int kvm_pic_init(struct kvm *kvm)
@@ -602,7 +602,7 @@ int kvm_pic_init(struct kvm *kvm)
 	 */
 	kvm_iodevice_init(&s->dev_master, &picdev_master_ops);
 	kvm_iodevice_init(&s->dev_slave, &picdev_slave_ops);
-	kvm_iodevice_init(&s->dev_eclr, &picdev_eclr_ops);
+	kvm_iodevice_init(&s->dev_elcr, &picdev_elcr_ops);
 	mutex_lock(&kvm->slots_lock);
 	ret = kvm_io_bus_register_dev(kvm, KVM_PIO_BUS, 0x20, 2,
 				      &s->dev_master);
@@ -613,7 +613,7 @@ int kvm_pic_init(struct kvm *kvm)
 	if (ret < 0)
 		goto fail_unreg_2;
 
-	ret = kvm_io_bus_register_dev(kvm, KVM_PIO_BUS, 0x4d0, 2, &s->dev_eclr);
+	ret = kvm_io_bus_register_dev(kvm, KVM_PIO_BUS, 0x4d0, 2, &s->dev_elcr);
 	if (ret < 0)
 		goto fail_unreg_1;
 
@@ -647,7 +647,7 @@ void kvm_pic_destroy(struct kvm *kvm)
 	mutex_lock(&kvm->slots_lock);
 	kvm_io_bus_unregister_dev(vpic->kvm, KVM_PIO_BUS, &vpic->dev_master);
 	kvm_io_bus_unregister_dev(vpic->kvm, KVM_PIO_BUS, &vpic->dev_slave);
-	kvm_io_bus_unregister_dev(vpic->kvm, KVM_PIO_BUS, &vpic->dev_eclr);
+	kvm_io_bus_unregister_dev(vpic->kvm, KVM_PIO_BUS, &vpic->dev_elcr);
 	mutex_unlock(&kvm->slots_lock);
 
 	kvm->arch.vpic = NULL;
diff --git a/arch/x86/kvm/irq.h b/arch/x86/kvm/irq.h
index 9b64abf..650642b 100644
--- a/arch/x86/kvm/irq.h
+++ b/arch/x86/kvm/irq.h
@@ -55,7 +55,7 @@ struct kvm_pic {
 	int output;		/* intr from master PIC */
 	struct kvm_io_device dev_master;
 	struct kvm_io_device dev_slave;
-	struct kvm_io_device dev_eclr;
+	struct kvm_io_device dev_elcr;
 	void (*ack_notifier)(void *opaque, int irq);
 	unsigned long irq_states[PIC_NUM_PINS];
 };
