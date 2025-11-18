Return-Path: <linux-tip-commits+bounces-7394-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B9EC6A4C8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 16:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 851022B6D9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 15:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F382D0C8A;
	Tue, 18 Nov 2025 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VoY9Jt/k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D/b1/ZvE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE6235F8A6;
	Tue, 18 Nov 2025 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763479606; cv=none; b=SV708HXXL73p+X45s2gMMAL1iMirs5NGcs/lUy776OcN87B8njVuCf3lMmM4PwrksHizdjXE6SSYsdZeEpaduxGYI6jvRdiFkvtdi3wGf7vJIfHX7NxPP9MkI1ASQZMLMs78GJzL/z7fon2fFJjYG5dyS6YJhOZ6/2WlP1Y9rg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763479606; c=relaxed/simple;
	bh=eXCmR1+VoeOPvEg0W84atFqXak/cgCTCEQ+uCUU5S2g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=toy6YSa9dy/JlC+enlVCeUgcMrH3NqNU167XE+YqVxK5vMU+w1E4PKNWMTDMrZyjetyE+h2eHV0yyP18qnxTvIKi3wlyAYGwTgWJ1QrZ78Md+NZFHraS/jv6/HVIKR9DiAbN2vlk4Q3aV3nA+fUB0IxanrI+c6uUJMdG6s22m/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VoY9Jt/k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D/b1/ZvE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Nov 2025 15:26:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763479602;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q9/GdM4ULSs3L4v1atr5fPV8BzyNEmsviZregcyWpeg=;
	b=VoY9Jt/kBv0Rf9lCT8M9ezOVlZz0SKT+LpBL0HWGUJmMBtg4Z+r90JtAh1iFx4tHKszWUR
	bpXw+47dXdB045CdhI65ohmksfTq9L/BBmEydH2hkwI0bWaRUNSDPh+whrw1gdz/xUbDl/
	1IBBDtORkOM10GzDldR2P3dJchaDlR3ZsaiXaUuBmCcvtL5OCbR0yt/DfC7+ZjNo+i5jAP
	5gVWiooLkvUtLQwTWGl4HvrGCd08JQBosl9Q3DHCug2Rtz1tdLl3vEKTWF6xmx+gMagf1e
	NyoPFOVXogdexw3N9pPtRQM/WatTCvLBiE9VcYoqtPyjHs3vc1GwZ5/8Km5fWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763479602;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q9/GdM4ULSs3L4v1atr5fPV8BzyNEmsviZregcyWpeg=;
	b=D/b1/ZvEa/U4kWPRjHWTPf5rAWn0Jb2Iqwbg1qW6Zut2wmEX9U20+/lDszY/nF9DFeBnkv
	6GyB2iRK9GzBn6Aw==
From: "tip-bot2 for Chengkaitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] genirq: Use raw_spinlock_irq() in irq_set_affinity_notifier()
Cc: Chengkaitao <chengkaitao@kylinos.cn>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20251118012754.61805-1-pilgrimtao@gmail.com>
References: <20251118012754.61805-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176347960117.498.17350947220693548435.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     9d3faec60b1303fbec53d7a9b48a8c0fc5ae029b
Gitweb:        https://git.kernel.org/tip/9d3faec60b1303fbec53d7a9b48a8c0fc5a=
e029b
Author:        Chengkaitao <chengkaitao@kylinos.cn>
AuthorDate:    Tue, 18 Nov 2025 09:27:54 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Nov 2025 16:19:40 +01:00

genirq: Use raw_spinlock_irq() in irq_set_affinity_notifier()

Since irq_set_affinity_notifier() may sleep, interrupts are enabled. So
raw_spinlock_irqsave() can be replaced with raw_spinlock_irq().

Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251118012754.61805-1-pilgrimtao@gmail.com
---
 kernel/irq/manage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c812b6f..c1ce30c 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -547,7 +547,7 @@ int irq_set_affinity_notifier(unsigned int irq, struct ir=
q_affinity_notify *noti
 		INIT_WORK(&notify->work, irq_affinity_notify);
 	}
=20
-	scoped_guard(raw_spinlock_irqsave, &desc->lock) {
+	scoped_guard(raw_spinlock_irq, &desc->lock) {
 		old_notify =3D desc->affinity_notify;
 		desc->affinity_notify =3D notify;
 	}

