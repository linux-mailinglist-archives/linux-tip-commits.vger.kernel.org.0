Return-Path: <linux-tip-commits+bounces-1804-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3EA93F2E1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 12:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9CBE1F22BB2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 10:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC29146587;
	Mon, 29 Jul 2024 10:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XtaEwQbx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Av/G+CHW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81262145B0F;
	Mon, 29 Jul 2024 10:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722249252; cv=none; b=UAJLGaRimb2qiY985o9one780dJayHH+KF9gyJbr6cQryqv0Aqex0Q2REKvWMQcctnRVKFkZ61BC/o4vMlk0an+Bcm2cqzmLjVb+B107OFKAqfOdHJ591KjfBEwI0byKboNFPYx1Vbs5ZKyKD7Qo65c0v6bQhqdOwldqXBnEvZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722249252; c=relaxed/simple;
	bh=GaEnoQN6H9zjkJ4x1b95aj4Sfu9q0/fiAXumczSbj9M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=b6Z2odz3EtmrAvZ0SVKVqag2MTlecuI4IAb+tWDU/YAr9pIDcUksLB8nYzM1QcBUkRWELx4XC6RBIb9kI1AdbYo3ujkqQmcOqU6GS5YRY4F0DNOU7Dd8rTomuG/rKNLS/eY231FUOM3LLoexzQ2lLmD3Z707rN5KeihrSsJaVPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XtaEwQbx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Av/G+CHW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 10:34:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722249248;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8PThzawAbRW7P3Gqsb1ChCBZTxHUkqIECE9Yk1iZUMY=;
	b=XtaEwQbxQTh783tDVByEj1r8F+zDTX44KeoD8NFbYubsqKFCuqke8Yj5k95ihqoe/PfEVb
	gKhVsvfAWi/TEVuJfPeGEH7l1ydqMVrqIsiS1vWFnOvZAc72EU+pRy6j6CTavZBxsN6Hi+
	8TI8T0wygH3vvfaLcrFgC+icTuN1wgjrJHuTDcuojBoBAVaRh/EnQUOPVCXdqttfm6UuJ4
	Lh+tqxEXx/iZuWZ+TO10bsXhmZThG+via1C43bEI9hNHnJ9qnz1konNJIMW3J3jJZp3C4n
	0JRmSQErwSqF4KFMAkeYQ7iBiAxx5/4QA0C26qHggUOqd8lCnk/ct3Yl5r6rqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722249248;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8PThzawAbRW7P3Gqsb1ChCBZTxHUkqIECE9Yk1iZUMY=;
	b=Av/G+CHWfQsHGMhxWynOpBlT3HiJjl4Ve76O34EXk+MRoVkMJKd4vy0KW1tfsCk2+/lWW6
	7BXyeEx9xSg7sNCA==
From: "tip-bot2 for Yang Yingliang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Fix unbalance set_rq_online/offline()
 in sched_cpu_deactivate()
Cc: stable@kernel.org, Yang Yingliang <yangyingliang@huawei.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240703031610.587047-5-yangyingliang@huaweicloud.com>
References: <20240703031610.587047-5-yangyingliang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224924844.2215.10671969655043849003.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fe7a11c78d2a9bdb8b50afc278a31ac177000948
Gitweb:        https://git.kernel.org/tip/fe7a11c78d2a9bdb8b50afc278a31ac177000948
Author:        Yang Yingliang <yangyingliang@huawei.com>
AuthorDate:    Wed, 03 Jul 2024 11:16:10 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 29 Jul 2024 12:22:33 +02:00

sched/core: Fix unbalance set_rq_online/offline() in sched_cpu_deactivate()

If cpuset_cpu_inactive() fails, set_rq_online() need be called to rollback.

Fixes: 120455c514f7 ("sched: Fix hotplug vs CPU bandwidth control")
Cc: stable@kernel.org
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240703031610.587047-5-yangyingliang@huaweicloud.com
---
 kernel/sched/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4d119e9..f3951e4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8022,6 +8022,7 @@ int sched_cpu_deactivate(unsigned int cpu)
 	ret = cpuset_cpu_inactive(cpu);
 	if (ret) {
 		sched_smt_present_inc(cpu);
+		sched_set_rq_online(rq, cpu);
 		balance_push_set(cpu, false);
 		set_cpu_active(cpu, true);
 		sched_update_numa(cpu, true);

