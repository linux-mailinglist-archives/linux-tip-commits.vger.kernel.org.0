Return-Path: <linux-tip-commits+bounces-4266-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7943A64A73
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6AF1882FB8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C0524169C;
	Mon, 17 Mar 2025 10:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D0UJ4jv9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SWLdo/iV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52944241684;
	Mon, 17 Mar 2025 10:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207697; cv=none; b=CZK0dAAXaf1JmNE1Ri2Tn+c6eDvg34LtbEwSI5DmZKSi7utsLyA5Tw/oBdhnljz1jA176mwtLaDd+Rl5Z2H/7QyYsKghEPLzU+PRC+zQDuVKRVS5smguXUxt5uyAX1zDSTMfp3T9v/Sz5sG6fL2RWLynN05Q+z/t27NRNnP2NgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207697; c=relaxed/simple;
	bh=Dvi7dt8MZ6WpKJKtLSjP+TqCBVrkOjmgQFjMBqkWMuA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FD283d52u4ZK24mRH6ymPEnpAFeDclOiiVS3N+oIhEBriQnIqBM9vaW7jzlm3sQm7TyyZTX/RtTF1DJxajrSLpUMJUKiZh1rJ3hA73HPadCdi5Vr7hlsOr8lOm2k8v71gSb7GkMYJYcCLWBZbo1Dz2W9ah5EzPBF5WueU+hHPBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D0UJ4jv9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SWLdo/iV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:34:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742207694;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3pyukO0ZEi78ZhitvxcST1CkBalm4cgXuBBH1Z1Bxk=;
	b=D0UJ4jv9a8wgSQRRWQI2b1ibzSE2w4+lYKEtWFsIxS9pQ3+tpp7JFxreOzD5Ol5V8o8kcP
	MV5yzyN1bg8JbZi7k20z6S/qIS8eMtB9WfESQ/wrCjYvnTkeGv6uOgHzr5I4+kOjApD6Tw
	I45e5mlybJMKGy0PXLhgBFpKEkKPSwcbJhaQumyyOMkuHDp8kHvGKFYkr+vEAqqyT0PJ12
	qsh2VF6iYq9YDlEyoYjQBMfmqPaQUn5BFC/aekvhugsM1aqHh/nnvEV+/qWa5czGtcKXKz
	BTmng2CdkVJb9BOrnNvafJt6iETRBqVJvzZcmtgwQ7itf/X43b61ZQzPHkE+Gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742207694;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3pyukO0ZEi78ZhitvxcST1CkBalm4cgXuBBH1Z1Bxk=;
	b=SWLdo/iVB1KbmVYYa/sEosDD1+3pAujP+Jjiot3gvHXQqQaPX8MMO29fVcEznnD2i6Rf0Z
	fQQ8UBIzFd6hsFDg==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] powerpc: Rely on generic printing of preemption model
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250314160810.2373416-6-bigeasy@linutronix.de>
References: <20250314160810.2373416-6-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220768834.14745.8118980644677092757.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     732ed149f7ac6278e33ccd62d13c604a134e6933
Gitweb:        https://git.kernel.org/tip/732ed149f7ac6278e33ccd62d13c604a134e6933
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 14 Mar 2025 17:08:06 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:23:39 +01:00

powerpc: Rely on generic printing of preemption model

After the first printk in __die() there is show_regs() ->
show_regs_print_info() which prints the current
preemption model.

Remove the preempion model from the arch code.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Link: https://lore.kernel.org/r/20250314160810.2373416-6-bigeasy@linutronix.de
---
 arch/powerpc/kernel/traps.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index edf5cab..cb8e935 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -263,10 +263,9 @@ static int __die(const char *str, struct pt_regs *regs, long err)
 {
 	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
 
-	printk("%s PAGE_SIZE=%luK%s%s%s%s%s%s %s\n",
+	printk("%s PAGE_SIZE=%luK%s %s%s%s%s %s\n",
 	       IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN) ? "LE" : "BE",
 	       PAGE_SIZE / 1024, get_mmu_str(),
-	       IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT" : "",
 	       IS_ENABLED(CONFIG_SMP) ? " SMP" : "",
 	       IS_ENABLED(CONFIG_SMP) ? (" NR_CPUS=" __stringify(NR_CPUS)) : "",
 	       debug_pagealloc_enabled() ? " DEBUG_PAGEALLOC" : "",

