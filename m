Return-Path: <linux-tip-commits+bounces-8375-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOX7FlOqqmnjVAEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8375-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Fri, 06 Mar 2026 11:20:03 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C5321E95A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 06 Mar 2026 11:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B088E300FB62
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Mar 2026 10:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8D836214F;
	Fri,  6 Mar 2026 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QjhUsWn+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CAFwdMhk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04B435B633;
	Fri,  6 Mar 2026 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772792058; cv=none; b=M5I+r5h2D3zzZEnt575n3k6NtTfdUWku5lR6F7fa2mqddS9Jo5oa0Zfj9z7oZ4upbwzVp8RzlfcBabKjrDHbxqjfpHfWDZfCQFkSlrmQn4S/9kcX0IA3PgEN9J8YRyZG23Ut+RQnVVP0RqLXkgougHnj4pSdnvb0JOGn76IcIUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772792058; c=relaxed/simple;
	bh=6iwPzoEVIqg7/F8S5xyxVVNRmDFMM7KHp+nuMMlwP00=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=c0S5M08+ifuiyhLhQI+N2dfn/rHbImT8ppeUMQO6/+GMqj65ZU/hBXshICiYQb4r2gBnWQnh6TNboGX7wsmK443NdK5HUkUS9WPMWW0X6OeFNaKypNJ+KgZaWzGWzwJ7g2EW0hRPDCWTM+QmxoNYpp3lFH1f9wlP6Fnao5fkBSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QjhUsWn+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CAFwdMhk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Mar 2026 10:14:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772792055;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V6h7SPnzmRZkRg/gypMG2Bto77D/Pajo6AX4suFcNyE=;
	b=QjhUsWn+rOR45wYoZ/0JMJ3g+08ufgDe1HkOnQsikqqamYmeWeqyf1wVT5mMY4Hwem2joN
	BzADRtc32QMpKEbH/6iuw5clC4gS1oKdaukBsJZAg1ud9BotTWxDYBocoKVGQhgSeoSgCP
	yAbhNt0+DNZFhkpMuF3UIQcRYSlDxtlKV7W9mIz7pn2y++eiqkfIPFwKPp+mKeqBNcL9QE
	3Cn3pNRpCByIM3tdkkCfpTDCmG40AudRxobvyBUALVJBghgDDZr/IKYWiSzDLBVdFXKuJC
	mtsVjC3naB2EP+aIOBVfPLGqAfV3XFjfVlKnQYVWqkWOJrrr82ewecHjSrQStw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772792055;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V6h7SPnzmRZkRg/gypMG2Bto77D/Pajo6AX4suFcNyE=;
	b=CAFwdMhkMWqU7M7VsBxj5vR+lthjvZgfXKmV9cLjhiUmKVCy1tk5Qs3sP+vtbpHwMpj4WC
	AS8ux2zLTVOzLhDg==
From: "tip-bot2 for rrrrr4413@gmail.com" <tip-bot2@linutronix.de>
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
Message-ID: <177279205425.1647592.7044256597939949372.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C6C5321E95A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [6.34 / 15.00];
	SPOOF_DISPLAY_NAME(8.00)[linutronix.de,gmail.com];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8375-lists,linux-tip-commits=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,infradead.org,alien8.de,kernel.org,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: add header
X-Spam: Yes

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f78f6b5bb82b6c430d649574fc85441f1a3c998e
Gitweb:        https://git.kernel.org/tip/f78f6b5bb82b6c430d649574fc85441f1a3=
c998e
Author:        rrrrr4413@gmail.com <rrrrr4413@gmail.com>
AuthorDate:    Tue, 13 Jan 2026 22:18:30 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 04 Mar 2026 17:06:13 +01:00

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

