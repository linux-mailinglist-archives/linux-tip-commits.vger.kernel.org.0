Return-Path: <linux-tip-commits+bounces-8378-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJSDCLWvqmluVQEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8378-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Fri, 06 Mar 2026 11:43:01 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 751A021F09B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 06 Mar 2026 11:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E14630D0249
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Mar 2026 10:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B4835B12B;
	Fri,  6 Mar 2026 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oALgA3Em";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mtjqMsWD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0395E364041;
	Fri,  6 Mar 2026 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772793684; cv=none; b=Es4feRPFySQvgWiRaeLpO8qRMVbxN0LiJzaRHYQ/ddRlJeFawe1tHaObkJ50z/gXk47/ZpQYRx5C/9ueJWVvyhUUxunrKUCsyC7BaeLUwm6Csx7U9d9po8UaKArcKIafWhwAMP50kaNmt3IIZnbkQ2hlD//lQ3bVtQFP1M4bUHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772793684; c=relaxed/simple;
	bh=9TfmSRX76bC6rABnQWouhv2JqMgvqUCP0M/wcxMt/xw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tHXyTgOY2T/s2z1Gj5PaLgaRukP+MR3jY8mxnl5f5ouyee+JpfyPUoY5YtkclwzAUN4KfqsT+s0c1g0kaokqM+7Q+RwHTjhQxz+3nPdy07WCovteD/otJsL+YUVD9x7jxzhvJLYLcfdWn5FsciB+VFdR3l0T3uGF5+uIbVA/qZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oALgA3Em; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mtjqMsWD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Mar 2026 10:41:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772793681;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2i1NIIlO5/gBLo2D6wy8PEVWLPO9QOq4Eh5NSHfkBMc=;
	b=oALgA3Em43MUBfBlUdbzRX0dfNCdNb4rogv/TdiTXnKDnfxOW/l29vKDvrhWtrXWmZoy9k
	WA8EEVmv+KehbDykVjCPXZXSZy2OxkS5llAmvNEPb0a9gKH0tjvgOF6uxknVRcwHIRQPI6
	fH1UCF96nD2iSrfZtkuPPGAl+9gQkJ6oSkpUm2Hl+nx3iGNmSlGuNZ7aqT0bNExSx8D370
	RduDfyjZ4/oeHN0woldgK6FiJDSOsvNIhTaZIVHioL3jtMRk5wjA+YBWLshs+l7MYnxDbt
	s87P22kP0z5H4NOzE5/e0GnNejshQ9lHrnj21ahUOij5wckUzRQOF98Y7AbBgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772793681;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2i1NIIlO5/gBLo2D6wy8PEVWLPO9QOq4Eh5NSHfkBMc=;
	b=mtjqMsWDTJZwvN2QuQdTs8hwaiPo6LvGkVkAuGJ03kggPYuh+f4r9bWnDH3YbMLd1KnUCi
	2FC4DNmbouP4gIDQ==
From: "tip-bot2 for Yen-Hsiang Hsu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/ibs: Fix comment typo in ibs_op_data
Cc: "Yen-Hsiang Hsu" <rrrrr4413@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260113141830.3204114-1-rrrrr4413@gmail.com>
References: <20260113141830.3204114-1-rrrrr4413@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177279367954.1647592.11443426980403602077.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 751A021F09B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8378-lists,linux-tip-commits=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,infradead.org,alien8.de,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     73cee0aad1ee2479fde2c9b753a1b66acb7d1b9a
Gitweb:        https://git.kernel.org/tip/73cee0aad1ee2479fde2c9b753a1b66acb7=
d1b9a
Author:        Yen-Hsiang Hsu <rrrrr4413@gmail.com>
AuthorDate:    Tue, 13 Jan 2026 22:18:30 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 06 Mar 2026 11:37:59 +01:00

perf/x86/amd/ibs: Fix comment typo in ibs_op_data

The comment for tag_to_ret_ctr in ibs_op_data says "15-31"
but it should be "16-31".

Fix the misleading comment. No functional changes.

Signed-off-by: Yen-Hsiang Hsu <rrrrr4413@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20260113141830.3204114-1-rrrrr4413@gmail.com
---
 arch/x86/include/asm/amd/ibs.h       | 2 +-
 tools/arch/x86/include/asm/amd/ibs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/amd/ibs.h b/arch/x86/include/asm/amd/ibs.h
index 4eac36c..68e24a1 100644
--- a/arch/x86/include/asm/amd/ibs.h
+++ b/arch/x86/include/asm/amd/ibs.h
@@ -77,7 +77,7 @@ union ibs_op_data {
 	__u64 val;
 	struct {
 		__u64	comp_to_ret_ctr:16,	/* 0-15: op completion to retire count */
-			tag_to_ret_ctr:16,	/* 15-31: op tag to retire count */
+			tag_to_ret_ctr:16,	/* 16-31: op tag to retire count */
 			reserved1:2,		/* 32-33: reserved */
 			op_return:1,		/* 34: return op */
 			op_brn_taken:1,		/* 35: taken branch op */
diff --git a/tools/arch/x86/include/asm/amd/ibs.h b/tools/arch/x86/include/as=
m/amd/ibs.h
index cbce54f..25c0000 100644
--- a/tools/arch/x86/include/asm/amd/ibs.h
+++ b/tools/arch/x86/include/asm/amd/ibs.h
@@ -77,7 +77,7 @@ union ibs_op_data {
 	__u64 val;
 	struct {
 		__u64	comp_to_ret_ctr:16,	/* 0-15: op completion to retire count */
-			tag_to_ret_ctr:16,	/* 15-31: op tag to retire count */
+			tag_to_ret_ctr:16,	/* 16-31: op tag to retire count */
 			reserved1:2,		/* 32-33: reserved */
 			op_return:1,		/* 34: return op */
 			op_brn_taken:1,		/* 35: taken branch op */

