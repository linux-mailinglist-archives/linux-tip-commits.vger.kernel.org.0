Return-Path: <linux-tip-commits+bounces-8368-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIWHFZHnqWnuHQEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8368-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Mar 2026 21:29:05 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F6E218256
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Mar 2026 21:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63EDC30847F7
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Mar 2026 20:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E3B339708;
	Thu,  5 Mar 2026 20:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c0aWVU/2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VZkUVgBN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA772D9ECD;
	Thu,  5 Mar 2026 20:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772742516; cv=none; b=MFoNKvWpO8DHDEZfzmp28H4yzW/M1L9dKxDxirUzeU39uzlj6d5IcEb/fI5XYGoxIQn6xGouNIlnS/E9pBy9KC3pcdPNCib2nDGyJ/Ybqs1I0gWmE0hxgj5NcT+09mRCt1QERA72iUfcdUwHXP4PP2CSxMy1mfK96NnC5w5lg44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772742516; c=relaxed/simple;
	bh=4OYfMYaORt/2ycAw/rcMqqXo1ceNCX/uc2f6fTwbk6E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oj6yIgLVdg+Iq6pxIQTQFd0pZeEjF/zOxuTtO7BAy8zIx050Er7ae0cd1qkc+KZhUn06ZC3o86IaadsKCMYuQj/y2K4k54hCEFfTczyDyf6OUa3343Ln829btH0gHT7P/oFgjePcttmf3W1BcXi6Ak/a98rHJ8DmXKB92pr0qqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c0aWVU/2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VZkUVgBN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Mar 2026 20:28:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772742513;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/jgPq7K0cPp/LAuNacRG5eO7AOFtDuOWYIGUpfigPuk=;
	b=c0aWVU/2ZQagCLCUYBFtExm8RQnTwCSy97wquOG9CDV3k5Wg+0b2dJ5HcxylyBJAs4qGgq
	a6jaV3S6Ulx95Jbjx3HVUrZv+Hu4V+7fFhWRIsT5nMm3FgbgMKM29I1hrF4uNpAwahX0Zj
	AE9ilepkGVTbCyS2qYCHRlaTLZgIXtgyHitvC7aJiL1/NE31NVNBgb+O79pq2xuWPZ3nSV
	ukQWK6W1qgd+Obl+UF9omDZzxTmSEp/mgta0uoST1+epjiXJ76QLVzAjHBXoMK8oYO/G9A
	Lm91GfTGaF5d+6jHrRY0gaa9+5BVqsbbspPbl5WxecuaOUUwQB5QBzIysjqJoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772742513;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/jgPq7K0cPp/LAuNacRG5eO7AOFtDuOWYIGUpfigPuk=;
	b=VZkUVgBNTxcqU9RX4bxqvg/lMyAOGylnFv+aVNzkp3WIiwtM/MoTJnJ/3vqj7HuugbPqza
	nG0aJGJg/th81PBA==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/cpu: Add platform ID to CPU info structure
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Sohil Mehta <sohil.mehta@intel.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260304181020.8D518228@davehans-spike.ostc.intel.com>
References: <20260304181020.8D518228@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177274251234.1647592.12938797273448265734.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: F1F6E218256
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
	TAGGED_FROM(0.00)[bounces-8368-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linutronix.de:dkim,msgid.link:url,vger.kernel.org:replyto];
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
X-Rspamd-Action: no action

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     d8630b67ca1edeea728dbb309b09d239e9db6bdf
Gitweb:        https://git.kernel.org/tip/d8630b67ca1edeea728dbb309b09d239e9d=
b6bdf
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Wed, 04 Mar 2026 10:10:20 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 05 Mar 2026 12:25:32 -08:00

x86/cpu: Add platform ID to CPU info structure

The end goal here is to be able to do x86_match_cpu() and match on a
specific platform ID. While it would be possible to stash this ID
off somewhere or read it dynamically, that approaches would not be
consistent with the other fields which can be matched.

Read the platform ID and store it in cpuinfo_x86.

There are lots of sites to set this new field. Place it near
the place c->microcode is established since the platform ID is
so closely intertwined with microcode updates.

Note: This should not grow the size of 'struct cpuinfo_x86' in
practice since the u8 fits next to another u8 in the structure.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Link: https://patch.msgid.link/20260304181020.8D518228@davehans-spike.ostc.in=
tel.com
---
 arch/x86/include/asm/microcode.h      | 2 ++
 arch/x86/include/asm/processor.h      | 5 +++++
 arch/x86/kernel/cpu/intel.c           | 1 +
 arch/x86/kernel/cpu/microcode/intel.c | 2 +-
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcod=
e.h
index 8b41f26..3c317d1 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -61,6 +61,8 @@ static inline int intel_microcode_get_datasize(struct micro=
code_header_intel *hd
 	return hdr->datasize ? : DEFAULT_UCODE_DATASIZE;
 }
=20
+extern u32 intel_get_platform_id(void);
+
 static inline u32 intel_get_microcode_revision(void)
 {
 	u32 rev, dummy;
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processo=
r.h
index a24c780..10b5355 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -140,6 +140,11 @@ struct cpuinfo_x86 {
 		__u32		x86_vfm;
 	};
 	__u8			x86_stepping;
+	union {
+		// MSR_IA32_PLATFORM_ID[52-50]
+		__u8			intel_platform_id;
+		__u8			amd_unused;
+	};
 #ifdef CONFIG_X86_64
 	/* Number of 4K pages in DTLB/ITLB combined(in pages): */
 	int			x86_tlbsize;
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 646ff33..f28c0ef 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -205,6 +205,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
=20
 	if (c->x86 >=3D 6 && !cpu_has(c, X86_FEATURE_IA64))
 		c->microcode =3D intel_get_microcode_revision();
+	c->intel_platform_id =3D intel_get_platform_id();
=20
 	/* Now if any of them are set, check the blacklist and clear the lot */
 	if ((cpu_has(c, X86_FEATURE_SPEC_CTRL) ||
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/micr=
ocode/intel.c
index 83c6cd2..37ac4af 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -134,7 +134,7 @@ static u32 intel_cpuid_vfm(void)
 	return IFM(fam, model);
 }
=20
-static u32 intel_get_platform_id(void)
+u32 intel_get_platform_id(void)
 {
 	unsigned int val[2];
=20

