Return-Path: <linux-tip-commits+bounces-7014-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B59C0F638
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 17:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D92E464CE8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 16:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0471319604;
	Mon, 27 Oct 2025 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WIFIw0RI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wBECQ2dH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B973191BA;
	Mon, 27 Oct 2025 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582672; cv=none; b=inxH3lrdcC1cD/ljmlFQwIc2Da2dZSrlorSbNols1t6ewmLvvcyjj5zjtDqw3+L/+R3B6CYGlg7xCeFz3jutvHccnez0sGVDvN07ECZ/868d6G8RMTPaBw3+7Jo5DPzsw/Oc6CeDLudc+zSEb48tQuy9wvxR8IdZLOdFm1Cgr+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582672; c=relaxed/simple;
	bh=GyiG04VSslxinNUFWhJHrDlB+D2J5rUWygOUZcLQvbA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=W5tkW84KtgMOuSx/Yey7/APJJSgKURbmdblrlJGxWYWMz3XI/EaUlx+Hp91GQbSwtROR8HepcUkXw05H/saIac45eL5kTlETTZt9Z2bObJjowzGb6UVhoC6GA4+IoyNFiPGEfXlkwj4iR/M05ApeBVn5jN1NTCBgpadrWr9wHa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WIFIw0RI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wBECQ2dH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 16:31:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761582667;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NzKv2kHfXRMlEnYtAJMYVmPctcqTsoJlkQ+MJxMeNh4=;
	b=WIFIw0RIvda82nAMmriYM10MfVQ+fnLm5yaBC5gLCcztlLECKbT1hj/UZjF6S8YU5iTTsc
	qL0kHIGNO7Z8TGi1+ULf9mF6O1a/oMuQrmceCXovrRRihpi5hgdV4FnvyeE0ytDOwUKkIK
	Gm4d9GVWNaOBc2JrIEXhTqffzOrhUTb9JCRsNRIHXa4b7OXivn2T2AGqZDFmIPRedevuTa
	7vtn0scP+F7WWvjaqjtm/OZW7IBftTWSBMg7yMQbxAL3nox4uSnw/avHSf3i7ihXKphIsF
	TfzfU4a6BIBTnHhFoSK71IaW2EyBWJQupst9Zw4vZDzSMHQp/FoDJkt6pqfNGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761582667;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NzKv2kHfXRMlEnYtAJMYVmPctcqTsoJlkQ+MJxMeNh4=;
	b=wBECQ2dHzyttpBMD4VUTnjFP0ygxr3ZbPDm8HJIv5XCjaNWflz79OuOL8bNU4yA6TZXjQU
	iE/aE3eHYRqmxvBw==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] genirq: Add affinity to percpu_devid interrupt requests
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251020122944.3074811-15-maz@kernel.org>
References: <20251020122944.3074811-15-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176158266641.2601451.654411425571553705.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     258e7d28a3dcd389239f9688058140c1a418b549
Gitweb:        https://git.kernel.org/tip/258e7d28a3dcd389239f9688058140c1a41=
8b549
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 20 Oct 2025 13:29:31 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Oct 2025 17:16:34 +01:00

genirq: Add affinity to percpu_devid interrupt requests

Add an affinity field to both the irqaction structure and the interrupt
request primitives. Nothing is making use of it yet, and the only value
used it NULL, which is used as a shorthand for cpu_possible_mask.

This will shortly get used with actual affinities.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Will Deacon <will@kernel.org>
Link: https://patch.msgid.link/20251020122944.3074811-15-maz@kernel.org
---
 include/linux/interrupt.h |  5 +++--
 kernel/irq/manage.c       | 14 ++++++++++----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 0ec1a71..52147d5 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -125,6 +125,7 @@ struct irqaction {
 		void		*dev_id;
 		void __percpu	*percpu_dev_id;
 	};
+	const struct cpumask	*affinity;
 	struct irqaction	*next;
 	irq_handler_t		thread_fn;
 	struct task_struct	*thread;
@@ -181,7 +182,7 @@ request_any_context_irq(unsigned int irq, irq_handler_t h=
andler,
 extern int __must_check
 __request_percpu_irq(unsigned int irq, irq_handler_t handler,
 		     unsigned long flags, const char *devname,
-		     void __percpu *percpu_dev_id);
+		     const cpumask_t *affinity, void __percpu *percpu_dev_id);
=20
 extern int __must_check
 request_nmi(unsigned int irq, irq_handler_t handler, unsigned long flags,
@@ -192,7 +193,7 @@ request_percpu_irq(unsigned int irq, irq_handler_t handle=
r,
 		   const char *devname, void __percpu *percpu_dev_id)
 {
 	return __request_percpu_irq(irq, handler, 0,
-				    devname, percpu_dev_id);
+				    devname, NULL, percpu_dev_id);
 }
=20
 extern int __must_check
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index d9ddc30..5f4c651 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2444,10 +2444,14 @@ int setup_percpu_irq(unsigned int irq, struct irqacti=
on *act)
=20
 static
 struct irqaction *create_percpu_irqaction(irq_handler_t handler, unsigned lo=
ng flags,
-					  const char *devname, void __percpu *dev_id)
+					  const char *devname, const cpumask_t *affinity,
+					  void __percpu *dev_id)
 {
 	struct irqaction *action;
=20
+	if (!affinity)
+		affinity =3D cpu_possible_mask;
+
 	action =3D kzalloc(sizeof(struct irqaction), GFP_KERNEL);
 	if (!action)
 		return NULL;
@@ -2456,6 +2460,7 @@ struct irqaction *create_percpu_irqaction(irq_handler_t=
 handler, unsigned long f
 	action->flags =3D flags | IRQF_PERCPU | IRQF_NO_SUSPEND;
 	action->name =3D devname;
 	action->percpu_dev_id =3D dev_id;
+	action->affinity =3D affinity;
=20
 	return action;
 }
@@ -2466,6 +2471,7 @@ struct irqaction *create_percpu_irqaction(irq_handler_t=
 handler, unsigned long f
  * @handler:	Function to be called when the IRQ occurs.
  * @flags:	Interrupt type flags (IRQF_TIMER only)
  * @devname:	An ascii name for the claiming device
+ * @affinity:	A cpumask describing the target CPUs for this interrupt
  * @dev_id:	A percpu cookie passed back to the handler function
  *
  * This call allocates interrupt resources, but doesn't enable the interrupt
@@ -2478,7 +2484,7 @@ struct irqaction *create_percpu_irqaction(irq_handler_t=
 handler, unsigned long f
  */
 int __request_percpu_irq(unsigned int irq, irq_handler_t handler,
 			 unsigned long flags, const char *devname,
-			 void __percpu *dev_id)
+			 const cpumask_t *affinity, void __percpu *dev_id)
 {
 	struct irqaction *action;
 	struct irq_desc *desc;
@@ -2495,7 +2501,7 @@ int __request_percpu_irq(unsigned int irq, irq_handler_=
t handler,
 	if (flags && flags !=3D IRQF_TIMER)
 		return -EINVAL;
=20
-	action =3D create_percpu_irqaction(handler, flags, devname, dev_id);
+	action =3D create_percpu_irqaction(handler, flags, devname, affinity, dev_i=
d);
 	if (!action)
 		return -ENOMEM;
=20
@@ -2560,7 +2566,7 @@ int request_percpu_nmi(unsigned int irq, irq_handler_t =
handler,
 		return -EINVAL;
=20
 	action =3D create_percpu_irqaction(handler, IRQF_NO_THREAD | IRQF_NOBALANCI=
NG,
-					 name, dev_id);
+					 name, NULL, dev_id);
 	if (!action)
 		return -ENOMEM;
=20

