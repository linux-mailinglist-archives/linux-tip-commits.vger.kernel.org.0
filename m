Return-Path: <linux-tip-commits+bounces-5328-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3786EAAD93E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645551BC2EC9
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 07:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF9C221FA5;
	Wed,  7 May 2025 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lprBDmlG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sZapD8RV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24C3221D93;
	Wed,  7 May 2025 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604672; cv=none; b=oPbZY+GqL0pdVrB1bGKNbq7hkc5pqfOGOdfln7CHir3LlJooC2H1uaJ9GVurWKmybxYbhtYi9mIAL+XAh02F6fKy9d1JqKZu7VS1+M9h57F/M/Bn4pVeKQPvtgBO0tLGvOT/24TgIqvd82YZQ/aHV/VehLBpwp+Go4qVHZNpvgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604672; c=relaxed/simple;
	bh=u+gBveKbvC/z68n5x/exS30N0vPI0QXiowb/QtH/lVk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tMV8/rctBkMZXGb/tmGMPTYAEHUDKdX7CxZUj5BbheAtWpC6iYvvI8793Sv2dgcJKvIEwz0uYKjqzCwbYe5Nwjr6Cav8XXeiKUK8TfhQ+21tEu6jbcqB528vrjuUqyTAhiJcr3R6jW0lzgQtd3NfVECnaBKt21O3k7wOjUsMxnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lprBDmlG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sZapD8RV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 07:57:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746604669;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCcgAeapgHAV+oqUB8LONYVYhcUa2W8AL6LrLZKayiM=;
	b=lprBDmlGyKL+hmvJ6RQjLF0f3d0BUH6O+vXJnWcVZDbudS/joUiZZzilkPp6l8bizf2KD+
	cdWfeDfQ5o8q4w1d7k3r0Wj7EDyi/hV7gLuReRUHGOI5WwGN22cjUjwlf4eh+wEolD0uxz
	jLW4mo7/y+7DuvYLo3LPnLcuq6/FU5o+6SnJc0l4RxJRbMFpmYbjm2bX5/KRzoU5t5AONR
	ifF/eSXtqcKr1B8ygpUp6ECjPRiT62DVpcUFw0bvv/W9r2rGI/6UYwJCey8yTo53xaIxFy
	cnEXo0nnuFB9MdKO9YjAaQz3kTjDkX89DSY6xNiU6IQUPKn+8kppAmMi1OBbXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746604669;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCcgAeapgHAV+oqUB8LONYVYhcUa2W8AL6LrLZKayiM=;
	b=sZapD8RVXZAWF3gNmFem8CEDR4T3L/5mWKo27vIddEjq1k3Ugr8hllW6wawe/a12r8IDAl
	ewlci+8+UxOPPpDg==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] Documentation: irq/concepts: Minor improvements
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-55-jirislaby@kernel.org>
References: <20250319092951.37667-55-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660466838.406.8321244781066755050.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     457a114de9a95948e2cc6ddecc4a73392a82aa4e
Gitweb:        https://git.kernel.org/tip/457a114de9a95948e2cc6ddecc4a73392a82aa4e
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:53:25 +02:00

Documentation: irq/concepts: Minor improvements

Just note in the docs:

 1) A PCI device as an example for shared interrupts
 2) A sparse tree can be used for interrupts too
 3) i8259s which have 8 pins

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-55-jirislaby@kernel.org

---
 Documentation/core-api/irq/concepts.rst | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/core-api/irq/concepts.rst b/Documentation/core-api/irq/concepts.rst
index f166006..7c4564f 100644
--- a/Documentation/core-api/irq/concepts.rst
+++ b/Documentation/core-api/irq/concepts.rst
@@ -4,18 +4,20 @@ What is an IRQ?
 
 An IRQ is an interrupt request from a device. Currently, they can come
 in over a pin, or over a packet. Several devices may be connected to
-the same pin thus sharing an IRQ.
+the same pin thus sharing an IRQ. Such as on legacy PCI bus: All devices
+typically share 4 lanes/pins. Note that each device can request an
+interrupt on each of the lanes.
 
 An IRQ number is a kernel identifier used to talk about a hardware
 interrupt source. Typically, this is an index into the global irq_desc
-array, but except for what linux/interrupt.h implements, the details
-are architecture specific.
+array or sparse_irqs tree. But except for what linux/interrupt.h
+implements, the details are architecture specific.
 
 An IRQ number is an enumeration of the possible interrupt sources on a
 machine. Typically, what is enumerated is the number of input pins on
 all of the interrupt controllers in the system. In the case of ISA,
-what is enumerated are the 16 input pins on the two i8259 interrupt
-controllers.
+what is enumerated are the 8 input pins on each of the two i8259
+interrupt controllers.
 
 Architectures can assign additional meaning to the IRQ numbers, and
 are encouraged to in the case where there is any manual configuration

