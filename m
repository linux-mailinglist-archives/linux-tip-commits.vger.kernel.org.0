Return-Path: <linux-tip-commits+bounces-8275-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gARdAGrKomnz5QQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8275-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 11:58:50 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD0F1C2625
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 11:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB85830C1BA9
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 10:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461BA42B736;
	Sat, 28 Feb 2026 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qlej2gM/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jRNhzzkZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB65439006;
	Sat, 28 Feb 2026 10:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772276208; cv=none; b=ZcqyMrooY7jg8oD6wisw64pNBH5K4kvQ2/9q+rb+jqXCvSupuodc2VFgwMa7axX9nAC7YDZwYNIJwptCrilNAc9gj6/t+LhBQTtecA814y2+q+Phw4ByekbGy2Irg1mAMJIRS6P44ZYjIcvv2HVtl6kLJ5Oj2WIxZ+NVmw1Z2pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772276208; c=relaxed/simple;
	bh=6tByoEuSkB5Vp37CR5e7QEMv6db1ATfWbgPR+S9xk7I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=meetEuj2V/U4E5FIKXoZMkRu0d0yJyfLSMkVEyTXms2VpDMMaxPqNM58Qty8opMIhPSL1d2qGtJk8PahHokbDZd2X+LeX8GK50euOzY6lJJ4S5eqivh0U+uW9uHxq5EuCFDz3ocGEONmBpqa4TdkYbs6kA8RAwK1RmuXoQkP9j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qlej2gM/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jRNhzzkZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 10:56:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772276204;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GgzPCaYGo6rg92y+77R9tCxkozzp3JbwEKyQF61L9do=;
	b=qlej2gM/kG1UkK/IYgiHvNkNL/Fn2yLfrCXbiocaf7s3p2kMoFTowy7YNLrv+nQ/JPKRHF
	+2sPYuEncAAdi4SvpJzRjlzeKKQuQdrBoRc7lFSqZGlp9EUeR4EN5NXN0k07/LgtjJprr/
	azPnF4GGrejW6SW4lNTzeat1rRepnYDZ/lr+MfeB3onpdsvUK9vmbd5pP0PNM0duTJWL9G
	49PidfoWwHUQ+lrdBpD0s4tQJ7yw83GMHYbaJfqGogq2svyzCAJ4l5PLbANshzl0FkMJJx
	tz7f7stRGv5BFfqTrEr5EtbV9vVdGNgRsiuV4zdstDBVX3s46QsmaiI8zZpp9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772276204;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GgzPCaYGo6rg92y+77R9tCxkozzp3JbwEKyQF61L9do=;
	b=jRNhzzkZPqk+j8ou65EcuX52L5qjizdv0xt2p5VrWHZVF7KRrHSvQs7MZHIUPvVQ1F4HAt
	vqB12+hQt8BfLrAA==
From: "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/ibs: Preserve PhyAddrVal bit when clearing
 PhyAddr MSR
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260216042216.1440-4-ravi.bangoria@amd.com>
References: <20260216042216.1440-4-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177227620368.1647592.6088317275674331828.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8275-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,infradead.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,vger.kernel.org:replyto,linutronix.de:dkim];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 6FD0F1C2625
X-Rspamd-Action: no action

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     723a290326e015b07931eabc603d3735999377be
Gitweb:        https://git.kernel.org/tip/723a290326e015b07931eabc603d3735999=
377be
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Mon, 16 Feb 2026 04:22:14=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:23 +01:00

perf/amd/ibs: Preserve PhyAddrVal bit when clearing PhyAddr MSR

Commit 50a53b60e141 ("perf/amd/ibs: Prevent leaking sensitive data to
userspace") zeroed the physical address and also cleared the PhyAddrVal
flag before copying the value into a perf sample to avoid exposing
physical addresses to unprivileged users.

Clearing PhyAddrVal, however, has an unintended side-effect: several
other IBS fields are considered valid only when this bit is set. As a
result, those otherwise correct fields are discarded, reducing IBS
functionality.

Continue to zero the physical address, but keep the PhyAddrVal bit
intact so the related fields remain usable while still preventing any
address leak.

Fixes: 50a53b60e141 ("perf/amd/ibs: Prevent leaking sensitive data to userspa=
ce")
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Link: https://patch.msgid.link/20260216042216.1440-4-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index e0b64cb..05b7c9f 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1217,12 +1217,10 @@ static void perf_ibs_phyaddr_clear(struct perf_ibs *p=
erf_ibs,
 				   struct perf_ibs_data *ibs_data)
 {
 	if (perf_ibs =3D=3D &perf_ibs_op) {
-		ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)] &=3D ~(1ULL << 18);
 		ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCPHYSAD)] =3D 0;
 		return;
 	}
=20
-	ibs_data->regs[ibs_fetch_msr_idx(MSR_AMD64_IBSFETCHCTL)] &=3D ~(1ULL << 52);
 	ibs_data->regs[ibs_fetch_msr_idx(MSR_AMD64_IBSFETCHPHYSAD)] =3D 0;
 }
=20

