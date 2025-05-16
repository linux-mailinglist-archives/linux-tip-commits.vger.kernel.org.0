Return-Path: <linux-tip-commits+bounces-5588-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB89ABA3E6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C07A20C85
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAE9280031;
	Fri, 16 May 2025 19:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DwM/ARMy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VXkV/rrD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318F727FD5C;
	Fri, 16 May 2025 19:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424244; cv=none; b=MOSBFM7y7qqELrUa6Sq+U0yKZSmduT1pHpHItDvqIyj/Mqw89/6Oy8TNovIkyJmKdOFpgZJuChGkcEQdbhjb9eiMyKHZ9A/X5oeW24dRmwXMfQtXM2cKnuZlXuuRnyfFHSMYp1iFHYGZ6d5jEHvEa6BgaJTEntIPJNQZqhFmU/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424244; c=relaxed/simple;
	bh=1EcCr2QSCgEbb8YoLaTJRAHmkNEz6/nPUncWlYvmQyE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tYuQb2SChPawH91llAjAXUL6ABdmYXdx0rWN3LbOj3VA5oRLHXIaaY36H++lONwHnPcvyjQ9JoSj0/YPyKXwSeHfmUqKi7YZJKFRHKfY9JQBaQW09ACNdLWUKyHRxVWvfg0UVENrVHA8xb9ggnUFgkuIbETHVpqJR3HA4mGV6VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DwM/ARMy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VXkV/rrD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:37:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424241;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVOqKi1oHQrbu2l68l3HPfR35rZ5zQWLZREJDpgJAwI=;
	b=DwM/ARMygPlE0Z37g0SOLlyldIG+4NBcfvMrQsPMlexwxnYHLYE60yF4B8XeuWYG/Jphp6
	wHVhr2PS5w9rCZT/ujP5VcyBo2ziK8qVxIheyPBdIxYObF7NBbqxxmTWrzgS6A78dJMLIh
	bHxK9tdDYcVzmiWzT7tiwv2DS7xR+YWLejtwEGQ1pM88Jm4E/WhnZXPDN1wjQaVJOR5cZv
	WMUn1pp8JxLkEhJ4K7/csEFP/JRODVlTnnbJUiFK9OYgWM4JjUSUu1iaxpauMFp8JhExih
	Aveoi6md/vmezRHa5YZtn68X1Xw4ozFPpaJLfmOoI3fSPuCTLx3sCj2zuc0/mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424241;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVOqKi1oHQrbu2l68l3HPfR35rZ5zQWLZREJDpgJAwI=;
	b=VXkV/rrDZpVHiLWZnpdT3vJvTAwqRxlHI7BcKc4I1DJbJC8WHPtjHt6D2ku7GoehSuKuXx
	hXae0+BSCFZ8hfCw==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/cleanups] Documentation: irq/concepts: Add commas and reflow
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-54-jirislaby@kernel.org>
References: <20250319092951.37667-54-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174742424009.406.1744499386888579352.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     2f7bd3293e4512323fd5334ef13cf2826de27666
Gitweb:        https://git.kernel.org/tip/2f7bd3293e4512323fd5334ef13cf2826de27666
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:46 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:06:13 +02:00

Documentation: irq/concepts: Add commas and reflow

For easier reading, it is always desired to add commas at some places in
text. Like before adverbs or after fronted sentences.

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-54-jirislaby@kernel.org



---
 Documentation/core-api/irq/concepts.rst | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/Documentation/core-api/irq/concepts.rst b/Documentation/core-api/irq/concepts.rst
index 4273806..f166006 100644
--- a/Documentation/core-api/irq/concepts.rst
+++ b/Documentation/core-api/irq/concepts.rst
@@ -2,23 +2,22 @@
 What is an IRQ?
 ===============
 
-An IRQ is an interrupt request from a device.
-Currently they can come in over a pin, or over a packet.
-Several devices may be connected to the same pin thus
-sharing an IRQ.
+An IRQ is an interrupt request from a device. Currently, they can come
+in over a pin, or over a packet. Several devices may be connected to
+the same pin thus sharing an IRQ.
 
 An IRQ number is a kernel identifier used to talk about a hardware
-interrupt source.  Typically this is an index into the global irq_desc
-array, but except for what linux/interrupt.h implements the details
+interrupt source. Typically, this is an index into the global irq_desc
+array, but except for what linux/interrupt.h implements, the details
 are architecture specific.
 
 An IRQ number is an enumeration of the possible interrupt sources on a
-machine.  Typically what is enumerated is the number of input pins on
-all of the interrupt controller in the system.  In the case of ISA
+machine. Typically, what is enumerated is the number of input pins on
+all of the interrupt controllers in the system. In the case of ISA,
 what is enumerated are the 16 input pins on the two i8259 interrupt
 controllers.
 
 Architectures can assign additional meaning to the IRQ numbers, and
-are encouraged to in the case  where there is any manual configuration
-of the hardware involved.  The ISA IRQs are a classic example of
+are encouraged to in the case where there is any manual configuration
+of the hardware involved. The ISA IRQs are a classic example of
 assigning this kind of additional meaning.

