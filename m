Return-Path: <linux-tip-commits+bounces-7319-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEA3C54FC3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Nov 2025 01:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DDD33B61CA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Nov 2025 00:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF43223DF6;
	Thu, 13 Nov 2025 00:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pQcPA9/Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uledez8Y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8545521FF4D;
	Thu, 13 Nov 2025 00:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762994496; cv=none; b=fMUZzN85tpib4Ijb5AnAShUqaJVYZJYU67rDKaO9/yTSq1dQX5GQLwX91qqyizcf0CwX1VzJRzdqGIIdTxZnaOyQ71cThVI/ur0nUl2sAirvCB7mUmrWeYe95w2QqYKhYsW5YCtIjR0mApC1TQXwPnm+CbYwQlxfaKs2lcMvopQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762994496; c=relaxed/simple;
	bh=0GVr9MBBDpfxPHFvwIGMbZ1NWp3Ulq7PVFSYmFByBBw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=bFyYxcZYolCjsxmWa571nIt6JKiHirj4J03ILEcDWBomegvaXbLDUeJldx6WipLcEHmG3foyhzJlUfzjtyz+lE9z60gITaYEr4jg35wVVMurvdUBcdtw8hz5UdVlW3wK+jlHIzhdUo90k12u4EjzIOkoOVObOppHonZYksLkNcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pQcPA9/Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uledez8Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Nov 2025 00:41:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762994492;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=AYm5r3+RgGcN1DnOs7Z0fYLSRReQoz6gMx6bGtwjl40=;
	b=pQcPA9/YHV9KCWJGrJE7OoQtKSg17oHUHIqGyMbJCwmcp4DYtj3K6ekuu1wjMRqmKPkIUT
	vaeLUIp9jIYYDBKzkxvoKqp2ORCO5yO0Oux9cG0KPHHUcTRbj7Tx5gBw42VCwrs+e+IH1j
	mkNF72HskKquXM+GQSUeBk9ZZm+JtuhSsbASXHG04IcwzFuF56Kp00M5ciFARNL2jrt1Vn
	1I98WI60IJSaHD0bGHLOqF2ejrHRvkwq3SsaFTAAIcORqtAOgcJjXpSogZ5Nv6Akb9zX+6
	U0FcGlmS1R0H3Y7oAYH+RQ6VbbE4tlz7rx7VNBJfU6VnGaqY9BgBDOELiUuLCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762994492;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=AYm5r3+RgGcN1DnOs7Z0fYLSRReQoz6gMx6bGtwjl40=;
	b=uledez8YEvLGJHrIDBvs4YBkRa6ScYbCxV2zDW720wEuZ1T9/CTTv0E9tOOhygH/LOiJta
	eRHntiVSCfI5noCg==
From: "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/mm: Drop unnecessary export of
 "ptdump_walk_pgd_level_debugfs"
Cc: Sean Christopherson <seanjc@google.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176299449096.498.5276320957650246416.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     e6f2d5866c55d9ed4d61c22692848b029ccd4f6c
Gitweb:        https://git.kernel.org/tip/e6f2d5866c55d9ed4d61c22692848b029cc=
d4f6c
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Wed, 12 Nov 2025 09:39:43 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 12 Nov 2025 15:24:42 -08:00

x86/mm: Drop unnecessary export of "ptdump_walk_pgd_level_debugfs"

Don't export "ptdump_walk_pgd_level_debugfs" as its sole user is
arch/x86/mm/debug_pagetables.c, which can't be built as a module.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://patch.msgid.link/20251112173944.1380633-4-seanjc%40google.com
---
 arch/x86/mm/dump_pagetables.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index a4700ef..2afa7a2 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -486,7 +486,6 @@ void ptdump_walk_pgd_level_debugfs(struct seq_file *m, st=
ruct mm_struct *mm,
 #endif
 	ptdump_walk_pgd_level_core(m, mm, pgd, false, false);
 }
-EXPORT_SYMBOL_GPL(ptdump_walk_pgd_level_debugfs);
=20
 void ptdump_walk_user_pgd_level_checkwx(void)
 {

