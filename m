Return-Path: <linux-tip-commits+bounces-5017-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0CAA90C17
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 21:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B575A2FE4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 19:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD11C224895;
	Wed, 16 Apr 2025 19:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tvPkZ9tp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dt9eosOO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594BA1E1C29;
	Wed, 16 Apr 2025 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744830999; cv=none; b=gBPhkNI5m4VgXmV7YLzw4/79Fejb1Y/PbNyc3TQiR2ovo53uqrK68DSymhHkF8uSMCP4KfT473CtjLkrOqtkvG1KPS/eMi2+9VlGGuQ3GxVuk/MFbc4aPvL2ICYgF2uh/Ef+xQ9mS4n1Fz0jvh+wj5vhtyZX7gIQy/9AgD0L7Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744830999; c=relaxed/simple;
	bh=SZMcSC+X8svsLySbJf5SSeunvF0lsAPEaaRtCUeEkOc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VeEkClQm46WdBCI2gptMi5eLm2prsHSV3MOUKG/fE545xJGoisxHN457Zz74hhbVZqL84j+8dQHeeq0xBe3qbW8oEtSDitNqCNOfZQQWHV6zELEJBJ105bTKnengcOT+Ue0Kh/7M7NOqSqhzqezaK7+OLMiZBh1ddhOF7lH+WM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tvPkZ9tp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dt9eosOO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Apr 2025 19:16:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744830996;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNccY/ADRR2DZr0ih3l50kUqu0NEDkOL5MBoDqr10FA=;
	b=tvPkZ9tp6J/2YCQKvTWeTayH8F4bjRVJ3j3PbEheDvHXKVs6juRKTo9CAgFjwJ7JLv8xzD
	jJOMDMx5veBoqRp/ztN7qkeEYrhyKFbY/fXUl1Cobx5510FNUB3m2w1mcctNNNV4+aXmLU
	OMqBIf4mBCgGnFDYWUpmtyvTmOCxEfq9VeCBetYy3US2XJe/U9Zh79UqeHbRPJHXE2fvqO
	IGdvrDbikoX/R9IEqGVGUdtrDdMQqBZY4EUqZnW1fCaY/OLS5XbDdPe5lOVWtfKrltRjLC
	h37nTTzSRgx0WTyuZ700qe+WBebUYoiA25KPWHppWGUL7SZ0I2MtEWfAgf5wvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744830996;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNccY/ADRR2DZr0ih3l50kUqu0NEDkOL5MBoDqr10FA=;
	b=dt9eosOOgM7rwc8cCFDPNo0tQIoUNgJGfLpnnSTU9xr9d5nz0Wq4q7uCkLTDnqvenNwxW+
	dE8bnSK3RXTcjGCg==
From: "tip-bot2 for K Prateek Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/debug: Print the local group's asym_prefer_cpu
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250409053446.23367-5-kprateek.nayak@amd.com>
References: <20250409053446.23367-5-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174483099510.31282.13375992960442766854.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     44671e21e3463f36f6c6e4b691216f60e85840e4
Gitweb:        https://git.kernel.org/tip/44671e21e3463f36f6c6e4b691216f60e85840e4
Author:        K Prateek Nayak <kprateek.nayak@amd.com>
AuthorDate:    Wed, 09 Apr 2025 05:34:46 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 16 Apr 2025 21:09:11 +02:00

sched/debug: Print the local group's asym_prefer_cpu

Add a file to read local group's "asym_prefer_cpu" from debugfs. This
information was useful when debugging issues where "asym_prefer_cpu" was
incorrectly set to a CPU with a lower asym priority.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250409053446.23367-5-kprateek.nayak@amd.com
---
 kernel/sched/debug.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 56ae54e..5572468 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -588,6 +588,10 @@ static void register_sd(struct sched_domain *sd, struct dentry *parent)
 	debugfs_create_file("flags", 0444, parent, &sd->flags, &sd_flags_fops);
 	debugfs_create_file("groups_flags", 0444, parent, &sd->groups->flags, &sd_flags_fops);
 	debugfs_create_u32("level", 0444, parent, (u32 *)&sd->level);
+
+	if (sd->flags & SD_ASYM_PACKING)
+		debugfs_create_u32("group_asym_prefer_cpu", 0444, parent,
+				   (u32 *)&sd->groups->asym_prefer_cpu);
 }
 
 void update_sched_domain_debugfs(void)

