Return-Path: <linux-tip-commits+bounces-8271-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAs+BMbKomnz5QQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8271-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 12:00:22 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CF01C2688
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 12:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED1C830F7583
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 10:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE9742E01C;
	Sat, 28 Feb 2026 10:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f+VWqCqH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="emQK/ka+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA99429823;
	Sat, 28 Feb 2026 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772276203; cv=none; b=d0v/z0EbGNulTIwwY49VwA/Yw7d9OGx5bQ189vXYbHT+OVQ9O0mj2ioAXMzupB7l+EVvcIeAFZP5TtQtxwyBXK3brdrBeqWAOL1LtC/SXaHBZNMOHX23sAE16c3KFAy8UUF3B5+hcEbobf8E2CS2kvS6r3MsPtWiVdbUa+pYB5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772276203; c=relaxed/simple;
	bh=b4DJtkZ9SIZGT5Ef6V1M4Sv6TI5whB+kaWJ6+uyC0SI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=S2onRoue7HgYSJVH0r6KJVhVGR0+/bMupksGxzl8MgeIlw3nMIpE3eR1JoHAFQhlqFCUS/adFHYb1W0cV1HH9p8Ahs+MklYcooStki6c488RxQl/V8tEaKo2urh6HtNdjK42IbDSPA517lfd5Vj4dSrMV6Isn4bC6vR+DSQN9Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f+VWqCqH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=emQK/ka+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 10:56:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772276200;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MSPaVTKx5rpxBZCQj1HDHX1KTN+XxmwVAkD4YitaPKY=;
	b=f+VWqCqHChNHCTC0z1aJnbYTW0grrmCjmLfzfYKpL1TCJprbk0lcWywf5EYYHybeFOjWc+
	MoPHynYJJBGDhaVJjvaTsGPScY8VLZUrNEAhz661GIRpfW14zW6eMLoxis9hVGTrpyFKL3
	PR39GQ6R7MicZZMminSVSzgQwdhEJv6s+sPcJOA4riRYGyze7iviA9ZgYEvApFyqoVtJDN
	DIHRDqBh1fmy+nVIcPrZZmnD59pdtaVTSKn9OjaQElI/FBrB2JxIVhQCJV/GUv5Q1g6Yxa
	yavyhEPbPfDiyKiX6HOLFTv/8WZl3U8HL0mZUdDSBx8SqB8/31Ungf8XVLJY0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772276200;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MSPaVTKx5rpxBZCQj1HDHX1KTN+XxmwVAkD4YitaPKY=;
	b=emQK/ka+U5ZhSG6VkdzZeGh23RMtwPP5bNHHutw6IY+iFz9VZzhB9diL98J1uErx4mbVvD
	IDg7osr12Fr3fyCw==
From: "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/amd/ibs: Add new MSRs and CPUID bits definitions
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260216042530.1546-3-ravi.bangoria@amd.com>
References: <20260216042530.1546-3-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177227619885.1647592.15059965615907168722.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8271-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,msgid.link:url,linutronix.de:dkim,vger.kernel.org:replyto,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 64CF01C2688
X-Rspamd-Action: no action

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e267b4178134e36e83ddfe4f7f5b4b162a286148
Gitweb:        https://git.kernel.org/tip/e267b4178134e36e83ddfe4f7f5b4b162a2=
86148
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Mon, 16 Feb 2026 04:25:25=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:24 +01:00

perf/amd/ibs: Add new MSRs and CPUID bits definitions

IBS on upcoming microarch introduced two new control MSRs and couple of
new features. Define macros for them.

New capabilities:

 o IBS_CAPS_DIS: Alternate Fetch and Op IBS disable bits
 o IBS_CAPS_FETCHLAT: Fetch Latency filter
 o IBS_CAPS_BIT63_FILTER: Virtual address bit 63 based filters for Fetch
   and Op
 o IBS_CAPS_STRMST_RMTSOCKET: Streaming store filter and indicator,
   remote socket indicator

New control MSRs for above features:

 o MSR_AMD64_IBSFETCHCTL2
 o MSR_AMD64_IBSOPCTL2

Also do cosmetic alignment changes.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://patch.msgid.link/20260216042530.1546-3-ravi.bangoria@amd.com
---
 arch/x86/include/asm/msr-index.h  |  2 +-
 arch/x86/include/asm/perf_event.h | 56 +++++++++++++++++++-----------
 2 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-inde=
x.h
index da5275d..e25434d 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -698,6 +698,8 @@
 #define MSR_AMD64_IBSBRTARGET		0xc001103b
 #define MSR_AMD64_ICIBSEXTDCTL		0xc001103c
 #define MSR_AMD64_IBSOPDATA4		0xc001103d
+#define MSR_AMD64_IBSOPCTL2		0xc001103e
+#define MSR_AMD64_IBSFETCHCTL2		0xc001103f
 #define MSR_AMD64_IBS_REG_COUNT_MAX	8 /* includes MSR_AMD64_IBSBRTARGET */
 #define MSR_AMD64_SVM_AVIC_DOORBELL	0xc001011b
 #define MSR_AMD64_VM_PAGE_FLUSH		0xc001011e
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_ev=
ent.h
index 67ecb98..752cb31 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -643,6 +643,10 @@ struct arch_pebs_cntr_header {
 #define IBS_CAPS_OPDATA4		(1U<<10)
 #define IBS_CAPS_ZEN4			(1U<<11)
 #define IBS_CAPS_OPLDLAT		(1U<<12)
+#define IBS_CAPS_DIS			(1U<<13)
+#define IBS_CAPS_FETCHLAT		(1U<<14)
+#define IBS_CAPS_BIT63_FILTER		(1U<<15)
+#define IBS_CAPS_STRMST_RMTSOCKET	(1U<<16)
 #define IBS_CAPS_OPDTLBPGSIZE		(1U<<19)
=20
 #define IBS_CAPS_DEFAULT		(IBS_CAPS_AVAIL		\
@@ -657,32 +661,44 @@ struct arch_pebs_cntr_header {
 #define IBSCTL_LVT_OFFSET_MASK		0x0F
=20
 /* IBS fetch bits/masks */
-#define IBS_FETCH_L3MISSONLY	(1ULL<<59)
-#define IBS_FETCH_RAND_EN	(1ULL<<57)
-#define IBS_FETCH_VAL		(1ULL<<49)
-#define IBS_FETCH_ENABLE	(1ULL<<48)
-#define IBS_FETCH_CNT		0xFFFF0000ULL
-#define IBS_FETCH_MAX_CNT	0x0000FFFFULL
+#define IBS_FETCH_L3MISSONLY		      (1ULL << 59)
+#define IBS_FETCH_RAND_EN		      (1ULL << 57)
+#define IBS_FETCH_VAL			      (1ULL << 49)
+#define IBS_FETCH_ENABLE		      (1ULL << 48)
+#define IBS_FETCH_CNT			     0xFFFF0000ULL
+#define IBS_FETCH_MAX_CNT		     0x0000FFFFULL
+
+#define IBS_FETCH_2_DIS			      (1ULL <<  0)
+#define IBS_FETCH_2_FETCHLAT_FILTER	    (0xFULL <<  1)
+#define IBS_FETCH_2_FETCHLAT_FILTER_SHIFT	       (1)
+#define IBS_FETCH_2_EXCL_RIP_63_EQ_1	      (1ULL <<  5)
+#define IBS_FETCH_2_EXCL_RIP_63_EQ_0	      (1ULL <<  6)
=20
 /*
  * IBS op bits/masks
  * The lower 7 bits of the current count are random bits
  * preloaded by hardware and ignored in software
  */
-#define IBS_OP_LDLAT_EN		(1ULL<<63)
-#define IBS_OP_LDLAT_THRSH	(0xFULL<<59)
-#define IBS_OP_LDLAT_THRSH_SHIFT	(59)
-#define IBS_OP_CUR_CNT		(0xFFF80ULL<<32)
-#define IBS_OP_CUR_CNT_RAND	(0x0007FULL<<32)
-#define IBS_OP_CUR_CNT_EXT_MASK	(0x7FULL<<52)
-#define IBS_OP_CNT_CTL		(1ULL<<19)
-#define IBS_OP_VAL		(1ULL<<18)
-#define IBS_OP_ENABLE		(1ULL<<17)
-#define IBS_OP_L3MISSONLY	(1ULL<<16)
-#define IBS_OP_MAX_CNT		0x0000FFFFULL
-#define IBS_OP_MAX_CNT_EXT	0x007FFFFFULL	/* not a register bit mask */
-#define IBS_OP_MAX_CNT_EXT_MASK	(0x7FULL<<20)	/* separate upper 7 bits */
-#define IBS_RIP_INVALID		(1ULL<<38)
+#define IBS_OP_LDLAT_EN			      (1ULL << 63)
+#define IBS_OP_LDLAT_THRSH		    (0xFULL << 59)
+#define IBS_OP_LDLAT_THRSH_SHIFT		      (59)
+#define IBS_OP_CUR_CNT			(0xFFF80ULL << 32)
+#define IBS_OP_CUR_CNT_RAND		(0x0007FULL << 32)
+#define IBS_OP_CUR_CNT_EXT_MASK		   (0x7FULL << 52)
+#define IBS_OP_CNT_CTL			      (1ULL << 19)
+#define IBS_OP_VAL			      (1ULL << 18)
+#define IBS_OP_ENABLE			      (1ULL << 17)
+#define IBS_OP_L3MISSONLY		      (1ULL << 16)
+#define IBS_OP_MAX_CNT			     0x0000FFFFULL
+#define IBS_OP_MAX_CNT_EXT		     0x007FFFFFULL	/* not a register bit mask */
+#define IBS_OP_MAX_CNT_EXT_MASK		   (0x7FULL << 20)	/* separate upper 7 bits=
 */
+#define IBS_RIP_INVALID			      (1ULL << 38)
+
+#define IBS_OP_2_DIS			      (1ULL <<  0)
+#define IBS_OP_2_EXCL_RIP_63_EQ_0	      (1ULL <<  1)
+#define IBS_OP_2_EXCL_RIP_63_EQ_1	      (1ULL <<  2)
+#define IBS_OP_2_STRM_ST_FILTER		      (1ULL <<  3)
+#define IBS_OP_2_STRM_ST_FILTER_SHIFT		       (3)
=20
 #ifdef CONFIG_X86_LOCAL_APIC
 extern u32 get_ibs_caps(void);

