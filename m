Return-Path: <linux-tip-commits+bounces-3146-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4991E9FDE10
	for <lists+linux-tip-commits@lfdr.de>; Sun, 29 Dec 2024 09:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28C227A115F
	for <lists+linux-tip-commits@lfdr.de>; Sun, 29 Dec 2024 08:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B38354654;
	Sun, 29 Dec 2024 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bmquyBjg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BhaLE+NO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71ED381C4;
	Sun, 29 Dec 2024 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735462785; cv=none; b=YUtBepkdHyMsSqIBL/1f1C3fPecshPzHr3HSkH2cxNSvxPxk9faNhZ/C4JshRtYxzyScKtMTiIilh7xBS9rcqIvWSkJikDRumsSCFMxmr9YoALqWh/UM63a1lbcFC01Lmnlyw/ofQEpxhWGP//0ZGKd035Cvb/cxikJJ/TOqjQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735462785; c=relaxed/simple;
	bh=lEOMq0bXoYZf2uVqfg6zmuJJJ+G7FL3/KKhQVRPQDIE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MxKKTS2KaiqfW3r+HTqTdtv5flp2LPEhv646tG6uG4hYKcHoEb/GMzHXjLxNs0cPoNmaGVYyBlu6dPQi5MkVA6riVc419/FKBQgz0xbj42lcfmNUIdHzPa8HcV8zWJSFBRg9FWzaQ268IO6cNVj5dgDMaW4j/NZA3KburVse8VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bmquyBjg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BhaLE+NO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 29 Dec 2024 08:59:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735462775;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3quHcYz3BOwi3nPiEYw3qx5y2ViyKdaQnkJRIBFBVw=;
	b=bmquyBjg+QdPejSRYUL1CG5zvqpChddPEwl6rPg76dz7nm7/mbWZON8luQd8MPh7klA0Hk
	0++WRt9PE8jzhH00hXttvPLhhPbv67uvIfpvVTwC1wNeYdiwdqiqivlgOFRsmZj2O4546H
	bDHSqBt5LMAdEjY3cfMNsVp68xr1dNuk4Z7XfROXREMJvY6qxcDlQ50/531qG7hnw2gqrX
	N09v7a+A4k1kpbIpb7Oia3X3RF1bdBTRj5qLYgFRqrreP0inYmxsfdiWWwjiUSugDPh4+o
	+n41cJ+8/r4Qe2uqIPYaRO/17eCQr98blW4eKgkOr0t5OdOSicB82FTcv728Gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735462775;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3quHcYz3BOwi3nPiEYw3qx5y2ViyKdaQnkJRIBFBVw=;
	b=BhaLE+NOM8QzFmMm6qlLQIYpZMZCl5N1/G2ASmzI0+fyvTzFyOUkFeMr6JUBNGAiHX5Wqu
	r63VkL/AKQtIqcDg==
From: "tip-bot2 for chenchangcheng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Add bch2_trans_unlocked_error() to
 bcachefs noreturns
Cc: chenchangcheng <chenchangcheng@kylinos.cn>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241220074847.3418134-1-ccc194101@163.com>
References: <20241220074847.3418134-1-ccc194101@163.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173546277274.399.11846838550317560565.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     31ad36a271290648e7c2288a03d7b933d20254d6
Gitweb:        https://git.kernel.org/tip/31ad36a271290648e7c2288a03d7b933d20254d6
Author:        chenchangcheng <ccc194101@163.com>
AuthorDate:    Fri, 20 Dec 2024 15:48:47 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 29 Dec 2024 09:52:21 +01:00

objtool: Add bch2_trans_unlocked_error() to bcachefs noreturns

Fix the following objtool warning during build time:

    fs/bcachefs/btree_trans_commit.o: warning: objtool: bch2_trans_commit_write_locked.isra.0() falls through to next function do_bch2_trans_commit.isra.0()
    fs/bcachefs/btree_trans_commit.o: warning: objtool: .text: unexpected end of section
......
    fs/bcachefs/btree_update.o: warning: objtool: bch2_trans_update_get_key_cache() falls through to next function flush_new_cached_update()
    fs/bcachefs/btree_update.o: warning: objtool: flush_new_cached_update() falls through to next function bch2_trans_update_by_path()

bch2_trans_unlocked_error() is an Obviously Correct (tm) panic() wrapper,
add it to the list of known noreturns.

[ mingo: Improved the changelog ]

Fixes: fd104e2967b7 ("bcachefs: bch2_trans_verify_not_unlocked()")
Signed-off-by: chenchangcheng <chenchangcheng@kylinos.cn>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20241220074847.3418134-1-ccc194101@163.com
---
 tools/objtool/noreturns.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
index f37614c..b217489 100644
--- a/tools/objtool/noreturns.h
+++ b/tools/objtool/noreturns.h
@@ -19,6 +19,7 @@ NORETURN(__x64_sys_exit_group)
 NORETURN(arch_cpu_idle_dead)
 NORETURN(bch2_trans_in_restart_error)
 NORETURN(bch2_trans_restart_error)
+NORETURN(bch2_trans_unlocked_error)
 NORETURN(cpu_bringup_and_idle)
 NORETURN(cpu_startup_entry)
 NORETURN(do_exit)

