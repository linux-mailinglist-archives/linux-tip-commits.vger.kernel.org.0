Return-Path: <linux-tip-commits+bounces-8364-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIc6NK/UqWmcFwEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8364-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Mar 2026 20:08:31 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E682173FB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Mar 2026 20:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC87230C9DDA
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Mar 2026 19:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BAE306B11;
	Thu,  5 Mar 2026 19:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uW7ldX/L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Q21pktt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD133002AB;
	Thu,  5 Mar 2026 19:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772737659; cv=none; b=cRugPdxg/zDZhQUedRtBA9rHAf+j/dyAlLJCBZv3y1lpClNNXt7Z+G5INuuO/pDmWbGtmXFX1hnOI/U883YdxMaEKPWYCsNKfh0vDpOp5DrbgwKWu3FTfFo0zCL+i35rTqcTb9a7kdQaI5mQ220HjmDUR972nV+OIQwL+PydTjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772737659; c=relaxed/simple;
	bh=iGDP+Vubvz/oU65Hp2eQwWdjB11o53E+8aFTUdOxzp8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=C09IwLbQS93y7PZHtaX9ZoNwxDBNzlMICKgC/rJAOTS6MtAly1H4mFVqK2vvMvwCX16LTf/zwh9ICbl6TxzLaFAUiak2IWWGl69Brl5JqpxMWU2G+pJfhylOen0Fl4epawwjq600mH+MScyBlRgIJnnICuDFm9L5ICIjlV4As30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uW7ldX/L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Q21pktt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Mar 2026 19:07:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772737654;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=exQcOvZKz0FE/4KXb1KwMBZXoedMEALMCgxNKB9oT/I=;
	b=uW7ldX/Luz0l1TklZ79dMuYVbOSOeDYEkOu8RdNuLvMXkbarJbF68X1QFhkDZEBC57zOzN
	3Bivgh5sLRj4GDbtKtEJSAIAGOVp86XHB+BXXrMOZwqHBxVkq8NFUx5pe9Tc0Zdr0KZB+X
	ljQK8KBWYW/uKmTg5gdcbP205JHDBdUiQAHQIvrnJeul0qTctiJW9UkySBXQIs7m8Anrge
	doKDjS2uZGWLqbJAyIPb4SOrbC1gQ4LSWoWT/cfbjRTKVtkcYaDaYIcW2+SBdHIF8/JE/R
	0UPPbH7vGBq846b5iwxF77LSEyrFk4IDbipoU6Ja0+/8K3kv3mBxF94tk5MQ0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772737654;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=exQcOvZKz0FE/4KXb1KwMBZXoedMEALMCgxNKB9oT/I=;
	b=3Q21pkttjPWhUtHh1egkOq3WIWUNreX0ah9Y3l7sYlM9CvaQOQV8wNMzsoRzwCqQyXn+5g
	tUMWmdNrt2tKh1Ag==
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
Message-ID: <177273765263.1647592.2775665751261167709.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 33E682173FB
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
	TAGGED_FROM(0.00)[bounces-8364-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,vger.kernel.org:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linutronix.de:dkim,msgid.link:url];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     c44b68639703434c52e4838f5080f0a02a2acaa6
Gitweb:        https://git.kernel.org/tip/c44b68639703434c52e4838f5080f0a02a2=
acaa6
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Wed, 04 Mar 2026 10:10:22 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 05 Mar 2026 10:41:30 -08:00

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

