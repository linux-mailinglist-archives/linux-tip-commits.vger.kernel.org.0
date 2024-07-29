Return-Path: <linux-tip-commits+bounces-1782-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCACB93F289
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 12:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56EBBB22666
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 10:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7F6143C74;
	Mon, 29 Jul 2024 10:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IhD3b/JF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JOrdR2uE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030C574055;
	Mon, 29 Jul 2024 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722248690; cv=none; b=DE5ZRgO7Ohzkb/hP2Tr4WwXxUPn4eGtiMQE0ja4AMiXx6r+0BsKwr4IWfDuFnhYQmWMnz3icf2L2OTttU78sloHiNFUWDyY8RG2s6WFzCoW/NftzU/3a/Y8I8z6AyiToDaUih2orQ8KiYvvnIgmUBXkcUMYl/GqzZsnX6GyEiQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722248690; c=relaxed/simple;
	bh=Xduj36L404fbCCxmgyvUv2316aNSMI5GuMKjdRCvBCI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=u4xE4vCFfAl4FactIgglHuh7mZgaDJzK9QUEGIu5Vz55O621kJ+kVHVbXZt/w4gMXwgNY9y9CHMX6LkDhAV7FaSD9ewIPUM2FT4AG06zwM5feBLiILCIUaejKcpI5tSoANqlGQg3WhehturbR7lt/nXc8GT+2hAX9vTMlRCgdGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IhD3b/JF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JOrdR2uE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 10:24:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722248687;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D7sFLtapWysYk/+H0li3CPtxt3IJ14RIODeYpvqZ0J0=;
	b=IhD3b/JFKL/gWE+yZ7rR4JgnjSZ75vsABxwQX0aAcVKTaRugptZmbBCokFZ1kmEOfC7yEL
	YnWqW6zkAtQIc7JFxsOwgGVuyu+26c2/+AVMdWqHBamFUJPPtYkoItKOGY79pq4yDvQ80A
	HzrdWc5w7XSAzowNDhroi0Q0LYbmX0bPZnXVXOj53uzly+rRecQTrMm+YQyGj4gINFVcBb
	mPH/2xWNE01dTzbrA3Jy1/BSH5l/XkJ4dYyPmp57CY3ZGqlXuo4znD9E0DaW/PehC9RPre
	tyongRQvOS+YJN8k9u3/Q7FYj3ZnVmV82HDUD7/cNlLyXUBsHF9UhC4Uyf1cCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722248687;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D7sFLtapWysYk/+H0li3CPtxt3IJ14RIODeYpvqZ0J0=;
	b=JOrdR2uENMYLy0LD9VX4Oss/6/jkHnv3PvFD4y7jsBtPbiCNxGcuHi+C9RSKFVJng0Hchl
	avaACjaJHYrvi5Bg==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/pvqspinlock: Correct the type of "old"
 variable in pv_kick_node()
Cc: Bibo Mao <maobibo@loongson.cn>, Uros Bizjak <ubizjak@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Waiman Long <longman@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240721164552.50175-1-ubizjak@gmail.com>
References: <20240721164552.50175-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224868680.2215.17583508895320127985.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     6623b0217d0c9bed80bfa43b778ce1c0eb03b497
Gitweb:        https://git.kernel.org/tip/6623b0217d0c9bed80bfa43b778ce1c0eb03b497
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Sun, 21 Jul 2024 18:45:41 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 29 Jul 2024 12:16:21 +02:00

locking/pvqspinlock: Correct the type of "old" variable in pv_kick_node()

"enum vcpu_state" is not compatible with "u8" type for all targets,
resulting in:

error: initialization of 'u8 *' {aka 'unsigned char *'} from incompatible pointer type 'enum vcpu_state *'

for LoongArch. Correct the type of "old" variable to "u8".

Fixes: fea0e1820b51 ("locking/pvqspinlock: Use try_cmpxchg() in qspinlock_paravirt.h")
Closes: https://lore.kernel.org/lkml/20240719024010.3296488-1-maobibo@loongson.cn/
Reported-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/r/20240721164552.50175-1-ubizjak@gmail.com
---
 kernel/locking/qspinlock_paravirt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index f5a36e6..ac2e225 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -357,7 +357,7 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
 static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
 {
 	struct pv_node *pn = (struct pv_node *)node;
-	enum vcpu_state old = vcpu_halted;
+	u8 old = vcpu_halted;
 	/*
 	 * If the vCPU is indeed halted, advance its state to match that of
 	 * pv_wait_node(). If OTOH this fails, the vCPU was running and will

