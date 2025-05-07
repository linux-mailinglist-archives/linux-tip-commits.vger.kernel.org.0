Return-Path: <linux-tip-commits+bounces-5329-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C775EAAD96F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 10:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49A1C3AFB5D
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 07:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA6922333B;
	Wed,  7 May 2025 07:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZeYJQy+E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ij3wBBKn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C0C221F2A;
	Wed,  7 May 2025 07:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604674; cv=none; b=cVlzRP6wUth3mgEt8ABF3nRLbTmzxRH/lkakdV3DIW5v6zQwb+8cVHYOErvxWeZoJmYNUc3XnwQXHh6TqIPu4m5Z7O6EmJrp6XsMMg3118UkwqkJI9L3aVLKGzLBubxT0iZuLOpqYQvl+4fEFNHAb2eRUKFJcLZEUCuSHhVtqU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604674; c=relaxed/simple;
	bh=XfAFhHHOIfeyjtRu1KJ3wTmmoy/lHfUkVQNEvd8gb6s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=B7SS0QVU/8Ru1qjeudFed3IdQWyUOaSPWVHm+bl9moLZAaHw833+xczlVd5xgzgp2pcpl/wM5NtLxH2mpmXNDKyF+QdQvceyE4UpjB+YD7hraizijDTai6moFG/SqzewmjZ6qf8SCG2Yx9MdczVgZ60fn4ilNKBCdY0VwRLoQGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZeYJQy+E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ij3wBBKn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 07:57:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746604669;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t5X5GSWnv2xCncuNAVZLbXOWMeTP8SWKOKBPKCfY4VQ=;
	b=ZeYJQy+EP/vRGsGjqlVm0s+3d6aS1SYUTuB0UhSXJ6d0Vje6tmWQ+dx2KyJ48A+CCgluKB
	ZEMlCTORuw8/5BkTJE/4EqxgEuy+i0YSxcwYSWMhahM+ZNLeylflXsn5CW2wQ22xUa3vwv
	8Y1hapzzymvbFELhtQKAu5TAPHd449GM1KN9p2EqA0dl+0xWPEt2JWHSizDY7uGDvjZHmw
	kXuKOGGG1QCAysF6iL2hIo8kvsF6IjVv2a505GoBmrynUYjLVNafyYn89lxCc0pBMojLta
	JtTQviLL0ht+/h6Vt0x2omzKEWkYpoT64A8Jd6Zm+rahaTEJqoIXpwfqwoFtjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746604669;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t5X5GSWnv2xCncuNAVZLbXOWMeTP8SWKOKBPKCfY4VQ=;
	b=ij3wBBKnsKFwyJswxIezgQqm8OIbRqV9I3kRd7AtvIuWC+110sGvqUGFSwLaa9szuPAcY5
	MeD29vuyrNzUskDg==
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
Message-ID: <174660466909.406.3617860077265845052.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     401dec9125415fc670d5d093190a2942ddb1963b
Gitweb:        https://git.kernel.org/tip/401dec9125415fc670d5d093190a2942ddb1963b
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:46 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:53:25 +02:00

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

