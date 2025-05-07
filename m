Return-Path: <linux-tip-commits+bounces-5420-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A63AAE106
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 15:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37FE44C450F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 13:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8482F28936D;
	Wed,  7 May 2025 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AJp148jA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/k9ivQNW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EA6288CBC;
	Wed,  7 May 2025 13:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625449; cv=none; b=Xwm/CaYnSy12xVwXzRIHrbpwTL/91ROQpPr+IT2v5sSnRBa9c4wAaXlIU0odS5jiYeOvxHZKA1d8odVabF0++iKTdcsnsEkBM9GzslCfjaypmF6DgPSusCFBVoXHFz1kjyCzNq+9DUgaJepuBH5k5xU0ET8InFoS9VKZNsxUUUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625449; c=relaxed/simple;
	bh=X22QIAk1DFi4/Q9xQTQFTk//uk+JDQvJ9uZJd/JkaJA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jQh83NANpXlR0RFPj1HRvTCKrcwssNhe/E7CNO5KrCW4EADUmERk8N+XdiU/ApJBSOu+AmqnlNiRrN7bJaMh/TVht3j6WmomAUr+ZDbwz3OtXTWwXa23qzJKDrkx1UrmvVgMhP3zAeZzN0SKV8Qoypht3a5/yHGRH9Q5nZfvL7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AJp148jA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/k9ivQNW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 13:44:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746625446;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2IwHRYUAKjPtogS5j4yazM1rZWVpIUGUNZ3V0ISlJBk=;
	b=AJp148jABJYxpGj1NOTnIL11RGPt5g26JW2ttc1UiTaMOq4E4Sp09Puy0PIx7B7NySMhd4
	KVIrA+oyBZrrLHCKFsor9gluRxVKF5agz79jraAAfhblpsrQpH6lw+BG4iSPF7zwTz+KhW
	iJyHBkwMfQ+CPhBfSBlQO7BiwjmgD1vEaAve4AQvhQdTJaMDkPNDD1XwSEd/+BnHNzsxVh
	+8/RX5XtZ+GzIUKlg2KWQh5KTG91bzekqfdq1LdbsJNuY0WLN/mlonrApNkqSXxwqt8flc
	NGRlhWM7XdEiKhfHVa3aH4TRi25Xnzi878D+mGdnxTrUOcmb7EW8RfGCEvTWMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746625446;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2IwHRYUAKjPtogS5j4yazM1rZWVpIUGUNZ3V0ISlJBk=;
	b=/k9ivQNWExjSkZoeHXoOj78PyYqEjnjfD6KTSlYOjaUVWkGt9pOehtuToxEkzQmr+BF1UE
	czUvGU0J2I6anwBw==
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
Message-ID: <174662544529.406.7231936541993959411.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     809997b2b2d14b762e24829a0ce63a4a75e6185b
Gitweb:        https://git.kernel.org/tip/809997b2b2d14b762e24829a0ce63a4a75e6185b
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 15:39:42 +02:00

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

