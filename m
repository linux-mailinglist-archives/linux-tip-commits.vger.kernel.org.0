Return-Path: <linux-tip-commits+bounces-7778-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A14C0CEBF9A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 31 Dec 2025 13:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EBED3047AF2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 31 Dec 2025 12:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E0732863E;
	Wed, 31 Dec 2025 12:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e0f/4JqZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tuIYpRzn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBC5328632;
	Wed, 31 Dec 2025 12:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767183945; cv=none; b=kktbJEAkuHDsys7NfrNmh/96VabnwIPBIjffLnqzyYXPFjcrP/EdT7E6ca033ZZPw3vL+WwnX+eq0U5dKrgfhao64Crn2+osTiVlewzYVWWEmrmACMr5SpNm9QRRcEdLAQE2fGBCnM/wUNUEEu07mqI15+XvBVuP6DFT2ZcTAnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767183945; c=relaxed/simple;
	bh=iqx9J9B4wx3WCSnsgrJdYpw0+CCLTkz+P+XfpeRJh3U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LT3vn+SKQcwCKnS55WIVXM9s0rW2KnuVtnjuiQNDXxVBP7aAGTufJT2ftWWHZvcQIlk4kPr2CVi4y0LS38wXbJ/4Ghc0TP/TBu/QjBuTd6mBaEyR2VCtLuFCMLaCB/q+LgqcCklr6IfqVlSVq5ELy2cpkqExUpuAPtz9VX6DDvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e0f/4JqZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tuIYpRzn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Dec 2025 12:25:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767183935;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2FfgyTEs4+FeV4K/GX6X+RJBnhwq++I4eKrr+wH6kao=;
	b=e0f/4JqZzNE0up4cz4yD7snTeU79mkhIUxPMEf2v1oHwMVOkSUjsw4kpyJdS2/Rp5sFqkF
	6VDiFMWG/d3sWgE0h0d9HDhCVw7Y2+hAsnZLUa0i89gJndEwDiVEkkRs2q5z3ATPxE2NFw
	ubvaU4gFBxHXJYn30bVSmf4eFfrNg+XliWs7fqtcreKAyDTNZG1FJCpplGQ77VuLD6bQ8p
	kR5KByMaT3p9GEYqjzkvpufNUbpZPKhrIhuV26AcoVhvmqaSLZpNMiDhNPTkdP1lp3176v
	qf3fXUfwvIyIGUd+5l4YcwPqWnLMEEyl3ZyqPtssIak6w/Xpsd3h/fcJq2EZsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767183935;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2FfgyTEs4+FeV4K/GX6X+RJBnhwq++I4eKrr+wH6kao=;
	b=tuIYpRznst2qEo7J/4llj3eEiW33Cbuis6QfZcqpg9VycYZ4NL6Zb2f90Pr619i5/lGcKE
	QjZxxZDE4arQrfAQ==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Add internal header guards
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251204124809.31783-3-bp@kernel.org>
References: <20251204124809.31783-3-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176718393452.510.5684949051130089129.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     f01c6489ad6ceb8d06eae0c5123fc6cf39276ff1
Gitweb:        https://git.kernel.org/tip/f01c6489ad6ceb8d06eae0c5123fc6cf392=
76ff1
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 04 Dec 2025 13:48:07 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 31 Dec 2025 13:16:06 +01:00

x86/sev: Add internal header guards

All headers need guards ifdeffery.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20251204124809.31783-3-bp@kernel.org
---
 arch/x86/coco/sev/internal.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/coco/sev/internal.h b/arch/x86/coco/sev/internal.h
index c58c47c..af991f1 100644
--- a/arch/x86/coco/sev/internal.h
+++ b/arch/x86/coco/sev/internal.h
@@ -1,4 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __X86_COCO_SEV_INTERNAL_H__
+#define __X86_COCO_SEV_INTERNAL_H__
=20
 #define DR7_RESET_VALUE        0x400
=20
@@ -85,3 +87,4 @@ enum es_result sev_es_ghcb_handle_msr(struct ghcb *ghcb, st=
ruct es_em_ctxt *ctxt
 u64 get_hv_features(void);
=20
 const struct snp_cpuid_table *snp_cpuid_get_table(void);
+#endif /* __X86_COCO_SEV_INTERNAL_H__ */

