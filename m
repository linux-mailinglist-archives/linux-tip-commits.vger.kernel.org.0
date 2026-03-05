Return-Path: <linux-tip-commits+bounces-8367-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CDBIYnnqWnuHQEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8367-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Mar 2026 21:28:57 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D441218240
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Mar 2026 21:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D1D23060BDE
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Mar 2026 20:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D8A3382E4;
	Thu,  5 Mar 2026 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T/LLo9UT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rCp9iLDw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227A22877DA;
	Thu,  5 Mar 2026 20:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772742515; cv=none; b=U9V5/BM9WrG7XVJbOCb25MwaGWh8N3Gf020fatqBDCeiIKv2YrnE297ZQaZ1dRP8MHjEwWO/IAsDGQzH77JTExX9zpu2BfOJhG8emNEVj3jGLWMGFBkKowkSKwrYPaZrIPeERuN+31IE8v20kTLT4DQ3oqIhgVd3tXnBqwnEXKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772742515; c=relaxed/simple;
	bh=4oD1ALaP4hcd60zU0I2DXm0nW3DENf/DzNbO40EyEyQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=icwIBUH/PFISuHdUgVsvg7agJUuMWIU8a2SkOM4VpaKqgLasCyuRjw3CmX0VvB5787SJnOK0QFRxlQhAGlcOlLkgSV4k4Tff+YOKKTg1GZSJLQW9EVOJBVfz7vMjpP9QExSX3bmNqI21qeepCSr4VK08N02BUyhTPLuz4qTVzLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T/LLo9UT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rCp9iLDw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Mar 2026 20:28:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772742512;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GoDq2OLBHjnWZtB9m52zzT4FnCwJnWZawnpNGYRu9EE=;
	b=T/LLo9UTqMl8a70oyYZl1NXi/snP6CVnZoQSuvH0dJC0omiv3CfCZFF/Rzfd/+YJH/Q9Ls
	5rg729plkhUrFhV8pu5xwJ4G/xz5l2KrK3yXihM3cYsNjBAX1e10yhg6CTkwjeR/BTdUna
	KPPeq14G+7jz7E4QjvwpvKb72UT5ZdiFcrG61ykF4DnLme8vMgX/xmdi/H/LKf8PWIZq6G
	nUnJXjiI0FrjgVTIyT67KAv4422+IMRRlZHOodbL163H5QXw4t25DeL67kpCizi0Yb2xht
	awsSOXeZGtaluy2bwZUi1UtiWrBh6rVQUEeVX6uYropTcLfCSZE0et9/QR6IFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772742512;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GoDq2OLBHjnWZtB9m52zzT4FnCwJnWZawnpNGYRu9EE=;
	b=rCp9iLDwItzXfOEccqph0VPdS5+q+Hy1iV0ZSiARMvuhCZbliOpJJ4dWoUr6AOUAIolE9c
	VjjmstPgQFMZLXAQ==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/microcode] x86/cpu: Add platform ID to CPU matching structure
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260304181022.058DF07C@davehans-spike.ostc.intel.com>
References: <20260304181022.058DF07C@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177274251128.1647592.14336397011881029644.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0D441218240
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8367-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linutronix.de:dkim,msgid.link:url,vger.kernel.org:replyto];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     fab0c75d500fd23de6ea1b30e44635418a6dae65
Gitweb:        https://git.kernel.org/tip/fab0c75d500fd23de6ea1b30e44635418a6=
dae65
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Wed, 04 Mar 2026 10:10:22 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 05 Mar 2026 12:25:38 -08:00

x86/cpu: Add platform ID to CPU matching structure

The existing x86_match_cpu() infrastructure can be used to match
a bunch of attributes of a CPU: vendor, family, model, steppings
and CPU features.

But, there's one more attribute that's missing and unable to be
matched against: the platform ID, enumerated on Intel CPUs in
MSR_IA32_PLATFORM_ID. It is a little more obscure and is only
queried during microcode loading. This is because Intel sometimes
has CPUs with identical family/model/stepping but which need
different microcode. These CPUs are differentiated with the
platform ID.

Add a field in 'struct x86_cpu_id' for the platform ID. Similar
to the stepping field, make the new field a mask of platform IDs.
Some examples:

	0x01: matches only platform ID 0x0
	0x02: matches only platform ID 0x1
	0x03: matches platform IDs 0x0 or 0x1
	0x80: matches only platform ID 0x7
	0xff: matches all 8 possible platform IDs

Since the mask is only a byte wide, it nestles in next to another
u8 and does not even increase the size of 'struct x86_cpu_id'.

Reserve the all 0's value as the wildcard (X86_PLATFORM_ANY). This
avoids forcing changes to existing 'struct x86_cpu_id' users.  They
can just continue to fill the field with 0's and their matching will
work exactly as before.

Note: If someone is ever looking for space in 'struct x86_cpu_id',
this new field could probably get stuck over in ->driver_data
for the one user that there is.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://patch.msgid.link/20260304181022.058DF07C@davehans-spike.ostc.in=
tel.com
---
 arch/x86/kernel/cpu/match.c     | 3 +++
 include/linux/mod_devicetable.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
index 6af1e8b..4604802 100644
--- a/arch/x86/kernel/cpu/match.c
+++ b/arch/x86/kernel/cpu/match.c
@@ -76,6 +76,9 @@ const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu=
_id *match)
 		if (m->steppings !=3D X86_STEPPING_ANY &&
 		    !(BIT(c->x86_stepping) & m->steppings))
 			continue;
+		if (m->platform_mask !=3D X86_PLATFORM_ANY &&
+		    !(BIT(c->intel_platform_id) & m->platform_mask))
+			continue;
 		if (m->feature !=3D X86_FEATURE_ANY && !cpu_has(c, m->feature))
 			continue;
 		if (!x86_match_vendor_cpu_type(c, m))
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 5b1725f..23ff240 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -691,6 +691,7 @@ struct x86_cpu_id {
 	__u16 feature;	/* bit index */
 	/* Solely for kernel-internal use: DO NOT EXPORT to userspace! */
 	__u16 flags;
+	__u8  platform_mask;
 	__u8  type;
 	kernel_ulong_t driver_data;
 };
@@ -702,6 +703,7 @@ struct x86_cpu_id {
 #define X86_STEPPING_ANY 0
 #define X86_STEP_MIN 0
 #define X86_STEP_MAX 0xf
+#define X86_PLATFORM_ANY 0x0
 #define X86_FEATURE_ANY 0	/* Same as FPU, you can't test for that */
 #define X86_CPU_TYPE_ANY 0
=20

