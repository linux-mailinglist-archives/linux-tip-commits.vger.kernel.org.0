Return-Path: <linux-tip-commits+bounces-5587-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D38EABA3E2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CBAE7B56CC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C7827FD79;
	Fri, 16 May 2025 19:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="05zne5mK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uT2WMPlZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19F527A470;
	Fri, 16 May 2025 19:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424243; cv=none; b=NPiRy1vXzUgXU2J/E0PnkBrkSX3Xe6EZ33zF1kpYo75hcF6EYEK4cemQCIt0QIxPG/1IuEqC9kXpGGl2AOuNY2ZLBLb45ZM+8sWYL0wkTRh5cTCra9kPttXIiUx7Cr9/ctpPYFSDaBeHG4l3yszlpbg3fUM/YPe2zvjhxfAUeCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424243; c=relaxed/simple;
	bh=iJgPQ7DAu5jR/STrSs1+JCc7LTrfWc7eiEeUv2LC0No=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AvsmxUV+nCQhA5Qnb5JuS5LUIJv+vT3NSLxZrQLqO4mWcuiRdp8Vms8mMqL9kCd43+d+MSgVkrt+YkMzqbWPyjiHAm1fQFo25+74pb3NXedXX1tm1iNUylwewxDdRl98gdZf8QpNDeWXl/qxv/0xrXP0ZDbyjhs0TUkQBPEK+fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=05zne5mK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uT2WMPlZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:37:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424240;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZGR3fdWQHtQvT1R0pJHldcpRiYKoWcoBGV8yYw2uasg=;
	b=05zne5mKsGnz/PruUKnRsG4D9e2aXTUBj+iOR+vB5/7E3Z3YxNs3TVohXSRfQtebIqK64T
	k8ZKgxlQzvBRKHnNbpXYrg8gX82MV5up/IyC6J1FwmTVwnH07qoMSMrdhoWzSOye1Y5Tma
	pcKiy+0mNkPdCjn16T/i/g8EBg8HOJ1LJ4xnycEltZYMT/XjMCHKA+7qwB5wHkT2Uic9rI
	CYsE9nzXiKPbbdkEsrtN3ibCb/nzsbEZVJAuUvNTtxgKxO7ZI8t9VRSfwDT/ZW12OJiVhc
	nMpiUEwtdPTLa1q/lZDez9VOdNqF1ISgxMcvSN38HLciiLkYa0JhArvguKF+BA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424240;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZGR3fdWQHtQvT1R0pJHldcpRiYKoWcoBGV8yYw2uasg=;
	b=uT2WMPlZYgCvSP3lK6U+ZOy1Ub89JCVjy4lU1TjM+KX2JbHOAaWd0aRavGU0fKUJUGkU7F
	30ywLjzqu/Y1xlAA==
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
Message-ID: <174742423931.406.14840311297258511309.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     225942f06e93dc4c24ce50df92e0eb5bcd2afbac
Gitweb:        https://git.kernel.org/tip/225942f06e93dc4c24ce50df92e0eb5bcd2afbac
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:06:13 +02:00

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

