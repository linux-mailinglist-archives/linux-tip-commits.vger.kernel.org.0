Return-Path: <linux-tip-commits+bounces-5272-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D736AAC5B9
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 15:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD965063B9
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 13:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FB428137D;
	Tue,  6 May 2025 13:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4uMovasD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2i/9jZvb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C35E280CD6;
	Tue,  6 May 2025 13:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537620; cv=none; b=BFiLLaAdHSchMmRqS80f1Z2dvX4Kvje7q8l5dW4O4+WuKmIBYM0HmU4AstPHGSP1n6OJV1KbwSgd+/5+r3YUG7p7p1hz1J1q+NqyXtkQnR5rY0jye70Dy75upzqqT6mYurJshFqziqJvlv0vLbYYds4BkJgbSpxCyq7RYp97IwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537620; c=relaxed/simple;
	bh=qqlWtyD170EiwIY1R6ptkem2eM+iKGspuOXgc0klz5s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=o87HX39qvXEphU2EokW/+ydn+EMGWVxvdQuZZW0cmzvSs8jiGTiz0DW49nUDqpELbhXSmaxbiZh1fe0EYlNqVzKWvR+MBp9+pj+ASvBwKySKS//whFAFNUqLo7LqyEZMmIytrZ/vU8wxSZ82M9pMhLiyw+t6GzrofC0KnwHAw/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4uMovasD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2i/9jZvb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 13:20:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746537616;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jewNMubmz5RA68zCr0dd1L9fuEXp63J+6xtD9BiAMLE=;
	b=4uMovasDUy4DDqdTdDkmKt4obmYktdMIY/foXiiXlYLuGk06pzRF2mKaTOQRLT9mW0oV+G
	KZjFPAosD8ptORAnSUoHzAyFeae2RJx0Qz/eTxSrExzbA5/Hmw3/ijrRZvrvDwlnB3qSY3
	/hmwTFZ3boZvGnb88OnOOVqSodu0SQXI2R0pu15C6Bn4ic37Ggg8S4iR9yx3rC2BvxvLm5
	BBeER9S0baj/T4dmZn7jWUZtgwcITXK1asbT5SMXKUrX5+g0MXhec88Rn7Uam4v0iEh+Vv
	ppuH48LHA2cODbbMdzqZGpeC9+pq6JOcJmNDrKsyAiBLBYUqW5ya+sI7gmVGYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746537616;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jewNMubmz5RA68zCr0dd1L9fuEXp63J+6xtD9BiAMLE=;
	b=2i/9jZvbp6HajFYeXdNOFoAttO71A7SJ9YH4jhL7zd6GGQy3dL3Iq29lWKkHDvJO45UgkD
	WZyPzOeBNu6usfBw==
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
Message-ID: <174653761576.406.12455291594611331872.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     343b4bf2869da43caf40906a0026f929ead85e22
Gitweb:        https://git.kernel.org/tip/343b4bf2869da43caf40906a0026f929ead85e22
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:46 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 14:59:09 +02:00

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

