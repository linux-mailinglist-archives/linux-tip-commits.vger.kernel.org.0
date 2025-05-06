Return-Path: <linux-tip-commits+bounces-5271-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4487AAC5B7
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 15:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7334C4F48
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 13:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEE5280CFF;
	Tue,  6 May 2025 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gEbBBsQy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UA9kl3+m"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71C2280327;
	Tue,  6 May 2025 13:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537619; cv=none; b=ug20WjpFIxFD0nYaXwf00M9HRDCkQNiKMAJSR9V0vTamZ1nNwOTaUeBgfQekNsszpwLV1Zb8JTDq4nVNk+dWxKLROgYmuqZsDIdW8tL4FoDWBh3+hPP9LLmyCvf09dIxGr2IM/YWrm+2rSbAAK+r272tNoiu+HcXqbivOuAuyB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537619; c=relaxed/simple;
	bh=9ab6dO4kidBqUWLQB4u1jXnA8ZM0ffhYfm6gPZnqVBk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BVkIWiGEHk+xhBiR9/6qPaburQ3DZBDXzWyHrcWKVfcvitzDn1rvwrroD8L3rXpVFB67+TRxzpbVnVU2pCmNdboD5WIV2OC9t1cnJrNvm8mkiVOPm9Y6ZoWYOoI0Kt+QKhZl9qDv3fvIVHVLjPaY7ByR+zpfL8UbDVqYR85+9xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gEbBBsQy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UA9kl3+m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 13:20:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746537615;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rgmi2nSM6UYOfDE5ZxkWJs6+gysmq8nIHaH1sQpiE4E=;
	b=gEbBBsQyC1gwckPXWAbDwwpwMzagecEG1N9kjZ102TFagmSPhfOYzQIT9gLyVv1kVRisPp
	TH9dKpt+oUUaJa/dyfIp7Lsv3i75/tkEoymFOqF86qcdDCoEg7mmxr4VleS4CLSI/wNfxk
	S6p/THnHWZmgLAYQvmZ3G9ZSjJoa3H7xOsjICf5erXGH6X/hQcSoWXGtsUE0eMmUwfqUFD
	fZzp/wcj1EknYPXqbwZ9AUcIOXX/UBZnP37WuUFifGn8QZSvqZnyPR5kgDM2nuqLu3GGUh
	64z753zd9IwRez/K3kEtbkQoH9ts7DopE/8kO4DEYf5pUQQeNHBZ4M7LQ3vFoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746537615;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rgmi2nSM6UYOfDE5ZxkWJs6+gysmq8nIHaH1sQpiE4E=;
	b=UA9kl3+mldeSMELxp9++KKCnVCrpxpNzQcnQOwsmtye+WoMFV80UQ9DRr4Hl+EQpu26h+2
	/0FWObulPc9qicAg==
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
Message-ID: <174653761499.406.4047609327811388776.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     22909d92a0298a22a6cbe39644a03af6d62983e2
Gitweb:        https://git.kernel.org/tip/22909d92a0298a22a6cbe39644a03af6d62983e2
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 14:59:09 +02:00

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

