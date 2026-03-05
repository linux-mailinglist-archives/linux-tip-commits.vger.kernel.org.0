Return-Path: <linux-tip-commits+bounces-8369-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DbpHIPnqWnuHQEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8369-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Mar 2026 21:28:51 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E4D218230
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Mar 2026 21:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B0993031AC3
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Mar 2026 20:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78859339708;
	Thu,  5 Mar 2026 20:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0SseXG/0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E5BlwSWz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52891FF7B3;
	Thu,  5 Mar 2026 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772742517; cv=none; b=kJDXefHQL0GUBzqV08pvw3ydJhshHpNL63mu1Mn9aKkwGTUxdeibZ7hYXVSw4m2hc7RfvOlCH8Mh9VJg15A04lSTRegO8+5GYN3UEirDCKU1miKTXKnZjI5SIXLh2dT47U+ob+n3gVR2Taqam33m4VXMalOLuoS2obefhgNSt+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772742517; c=relaxed/simple;
	bh=alIjhtozDglm4NrCKVrdUzjDEDHDa/Lw3ta5Em8Gl7o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AnKPqabY3oepl8Z0LFrVyu2jdtDgLHYvoMKcXnym5CNq95Y+/Y2K0oGVpOqM0WpVKQzHBsu50uOcSEA5H7Vt2NLlSUHSjyHSb1kbJPYgHpj7XGsEDAz4T032vQIWHrge3X0oSaYkvHs/ZXp6wIrm5TyZykdqX2YZCeOKO66SePQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0SseXG/0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E5BlwSWz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Mar 2026 20:28:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772742511;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hGGl8pXWmD78s2OPnWtCKzt9NpNOM3dBZpv2CVCFG4=;
	b=0SseXG/0fJDPZl7uHAdcxZzBaA9T9/Hwnhq3UxcKZfVX/L/W9ZH214416lOywKVDfDaIzi
	9dxXaEdoQpkxF6lUAC3b8Kr20XyyCNA2NI2tORuWa+QcOG94wm13zZU2zXkTgr84fV5NJv
	TblPLd0wBguHLehKDMhJF+pjfk4voONiNdndK0VBNdl0czPrOXSzwc3V/Kzvfniq6PH98g
	vnXGl9CXpGRW5Bzu7W3iz2/H7dp0fYqllk0cimeqafGftAWBpjiP7kYYd5XpjgPK6OkKBJ
	gUzvhNhMnx9mEDhyBiJ73ZX+01S5ADao+7CG/1DwJsTr/e84oe6emIVjcxIsUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772742511;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hGGl8pXWmD78s2OPnWtCKzt9NpNOM3dBZpv2CVCFG4=;
	b=E5BlwSWzs8KKqxkOJFCcQNItWlIWQUy6Tz/wTXrZ2gLKqB/+Egor6R0DCh1CgNl9GAggDM
	AEK06kofm3uGLwBw==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Add platform mask to Intel
 microcode "old" list
Cc: Jon Kohler <jon@nutanix.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Sohil Mehta <sohil.mehta@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260304181024.76E3F038@davehans-spike.ostc.intel.com>
References: <20260304181024.76E3F038@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177274251015.1647592.6988444041360518631.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B1E4D218230
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
	TAGGED_FROM(0.00)[bounces-8369-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:replyto,linutronix.de:dkim,msgid.link:url,intel.com:email,nutanix.com:email]
X-Rspamd-Action: no action

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     7989c39341348e3507282d88a564cb20d83a0829
Gitweb:        https://git.kernel.org/tip/7989c39341348e3507282d88a564cb20d83=
a0829
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Wed, 04 Mar 2026 10:10:24 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 05 Mar 2026 12:25:45 -08:00

x86/microcode: Add platform mask to Intel microcode "old" list

Intel sometimes has CPUs with identical family/model/stepping but
which need different microcode. These CPUs are differentiated with the
platform ID.

The Intel "microcode-20250512" release was used to generate the
existing contents of intel-ucode-defs.h. Use that same release and add
the platform mask to the definitions.

This makes the list a few entries longer because some CPUs previously
that shared a definition now need two or more. for example for the
ancient Pentium III there are two CPUs that differ only in their
platform and have two different microcode versions (note:
.driver_data is the microcode version):

	{ ..., .model =3D 0x05, .steppings =3D 0x0001, .platform_mask =3D 0x01, .dri=
ver_data =3D 0x40 },
	{ ..., .model =3D 0x05, .steppings =3D 0x0001, .platform_mask =3D 0x08, .dri=
ver_data =3D 0x45 },

Another example is the state-of-the-art Granite Rapids:

	{ ...,  .model =3D 0xad, .steppings =3D 0x0002, .platform_mask =3D 0x20, .dr=
iver_data =3D 0xa0000d1 },
	{ ...,  .model =3D 0xad, .steppings =3D 0x0002, .platform_mask =3D 0x95, .dr=
iver_data =3D 0x10003a2 },

As you can see, this differentiation with platform ID has been
necessary for a long time and is still relevant today.

Without the platform matching, the old microcode table is incomplete.
For instance, it might lead someone with a Pentium III, platform 0x0,
and microcode 0x40 to think that they should have microcode 0x45,
which is really only for platform 0x4 (.platform_mask=3D=3D0x08).

In practice, this meant that folks with fully updated microcode were
seeing "Vulnerable" in the "old_microcode" file.

1. https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files

Closes: https://lore.kernel.org/all/38660F8F-499E-48CD-B58B-4822228A5941@nuta=
nix.com/
Fixes: 4e2c719782a8 ("x86/cpu: Help users notice when running old Intel micro=
code")
Reported-by: Jon Kohler <jon@nutanix.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/all/3ECBB974-C6F0-47A7-94B6-3646347F1CC2@nutani=
x.com/
Link: https://patch.msgid.link/20260304181024.76E3F038@davehans-spike.ostc.in=
tel.com
---
 arch/x86/kernel/cpu/microcode/intel-ucode-defs.h | 398 ++++++++------
 1 file changed, 238 insertions(+), 160 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel-ucode-defs.h b/arch/x86/kern=
el/cpu/microcode/intel-ucode-defs.h
index 2d48e65..72c8809 100644
--- a/arch/x86/kernel/cpu/microcode/intel-ucode-defs.h
+++ b/arch/x86/kernel/cpu/microcode/intel-ucode-defs.h
@@ -1,160 +1,238 @@
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x03, .steppings =3D 0x0004, .driver_data =3D 0x2 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x05, .steppings =3D 0x0001, .driver_data =3D 0x45 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x05, .steppings =3D 0x0002, .driver_data =3D 0x40 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x05, .steppings =3D 0x0004, .driver_data =3D 0x2c },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x05, .steppings =3D 0x0008, .driver_data =3D 0x10 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x06, .steppings =3D 0x0001, .driver_data =3D 0xa },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x06, .steppings =3D 0x0020, .driver_data =3D 0x3 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x06, .steppings =3D 0x0400, .driver_data =3D 0xd },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x06, .steppings =3D 0x2000, .driver_data =3D 0x7 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x07, .steppings =3D 0x0002, .driver_data =3D 0x14 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x07, .steppings =3D 0x0004, .driver_data =3D 0x38 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x07, .steppings =3D 0x0008, .driver_data =3D 0x2e },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x08, .steppings =3D 0x0002, .driver_data =3D 0x11 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x08, .steppings =3D 0x0008, .driver_data =3D 0x8 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x08, .steppings =3D 0x0040, .driver_data =3D 0xc },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x08, .steppings =3D 0x0400, .driver_data =3D 0x5 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x09, .steppings =3D 0x0020, .driver_data =3D 0x47 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0a, .steppings =3D 0x0001, .driver_data =3D 0x3 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0a, .steppings =3D 0x0002, .driver_data =3D 0x1 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0b, .steppings =3D 0x0002, .driver_data =3D 0x1d },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0b, .steppings =3D 0x0010, .driver_data =3D 0x2 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0d, .steppings =3D 0x0040, .driver_data =3D 0x18 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0e, .steppings =3D 0x0100, .driver_data =3D 0x39 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0e, .steppings =3D 0x1000, .driver_data =3D 0x59 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0f, .steppings =3D 0x0004, .driver_data =3D 0x5d },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0f, .steppings =3D 0x0040, .driver_data =3D 0xd2 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0f, .steppings =3D 0x0080, .driver_data =3D 0x6b },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0f, .steppings =3D 0x0400, .driver_data =3D 0x95 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0f, .steppings =3D 0x0800, .driver_data =3D 0xbc },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0f, .steppings =3D 0x2000, .driver_data =3D 0xa4 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x16, .steppings =3D 0x0002, .driver_data =3D 0x44 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x17, .steppings =3D 0x0040, .driver_data =3D 0x60f =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x17, .steppings =3D 0x0080, .driver_data =3D 0x70a =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x17, .steppings =3D 0x0400, .driver_data =3D 0xa0b =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x1a, .steppings =3D 0x0010, .driver_data =3D 0x12 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x1a, .steppings =3D 0x0020, .driver_data =3D 0x1d },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x1c, .steppings =3D 0x0004, .driver_data =3D 0x219 =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x1c, .steppings =3D 0x0400, .driver_data =3D 0x107 =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x1d, .steppings =3D 0x0002, .driver_data =3D 0x29 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x1e, .steppings =3D 0x0020, .driver_data =3D 0xa },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x25, .steppings =3D 0x0004, .driver_data =3D 0x11 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x25, .steppings =3D 0x0020, .driver_data =3D 0x7 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x26, .steppings =3D 0x0002, .driver_data =3D 0x105 =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x2a, .steppings =3D 0x0080, .driver_data =3D 0x2f },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x2c, .steppings =3D 0x0004, .driver_data =3D 0x1f },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x2d, .steppings =3D 0x0040, .driver_data =3D 0x621 =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x2d, .steppings =3D 0x0080, .driver_data =3D 0x71a =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x2e, .steppings =3D 0x0040, .driver_data =3D 0xd },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x2f, .steppings =3D 0x0004, .driver_data =3D 0x3b },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x37, .steppings =3D 0x0100, .driver_data =3D 0x838 =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x37, .steppings =3D 0x0200, .driver_data =3D 0x90d =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x3a, .steppings =3D 0x0200, .driver_data =3D 0x21 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x3c, .steppings =3D 0x0008, .driver_data =3D 0x28 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x3d, .steppings =3D 0x0010, .driver_data =3D 0x2f },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x3e, .steppings =3D 0x0010, .driver_data =3D 0x42e =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x3e, .steppings =3D 0x0040, .driver_data =3D 0x600 =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x3e, .steppings =3D 0x0080, .driver_data =3D 0x715 =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x3f, .steppings =3D 0x0004, .driver_data =3D 0x49 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x3f, .steppings =3D 0x0010, .driver_data =3D 0x1a },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x45, .steppings =3D 0x0002, .driver_data =3D 0x26 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x46, .steppings =3D 0x0002, .driver_data =3D 0x1c },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x47, .steppings =3D 0x0002, .driver_data =3D 0x22 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x4c, .steppings =3D 0x0008, .driver_data =3D 0x368 =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x4c, .steppings =3D 0x0010, .driver_data =3D 0x411 =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x4d, .steppings =3D 0x0100, .driver_data =3D 0x12d =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x4e, .steppings =3D 0x0008, .driver_data =3D 0xf0 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x55, .steppings =3D 0x0008, .driver_data =3D 0x1000=
191 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x55, .steppings =3D 0x0010, .driver_data =3D 0x2007=
006 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x55, .steppings =3D 0x0020, .driver_data =3D 0x3000=
010 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x55, .steppings =3D 0x0080, .driver_data =3D 0x5003=
901 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x55, .steppings =3D 0x0800, .driver_data =3D 0x7002=
b01 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x56, .steppings =3D 0x0004, .driver_data =3D 0x1c },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x56, .steppings =3D 0x0008, .driver_data =3D 0x7000=
01c },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x56, .steppings =3D 0x0010, .driver_data =3D 0xf000=
01a },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x56, .steppings =3D 0x0020, .driver_data =3D 0xe000=
015 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x5c, .steppings =3D 0x0004, .driver_data =3D 0x14 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x5c, .steppings =3D 0x0200, .driver_data =3D 0x48 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x5c, .steppings =3D 0x0400, .driver_data =3D 0x28 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x5e, .steppings =3D 0x0008, .driver_data =3D 0xf0 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x5f, .steppings =3D 0x0002, .driver_data =3D 0x3e },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x66, .steppings =3D 0x0008, .driver_data =3D 0x2a },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x6a, .steppings =3D 0x0020, .driver_data =3D 0xc000=
2f0 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x6a, .steppings =3D 0x0040, .driver_data =3D 0xd000=
404 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x6c, .steppings =3D 0x0002, .driver_data =3D 0x1000=
2d0 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x7a, .steppings =3D 0x0002, .driver_data =3D 0x42 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x7a, .steppings =3D 0x0100, .driver_data =3D 0x26 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x7e, .steppings =3D 0x0020, .driver_data =3D 0xca },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8a, .steppings =3D 0x0002, .driver_data =3D 0x33 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8c, .steppings =3D 0x0002, .driver_data =3D 0xbc },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8c, .steppings =3D 0x0004, .driver_data =3D 0x3c },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8d, .steppings =3D 0x0002, .driver_data =3D 0x56 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8e, .steppings =3D 0x0200, .driver_data =3D 0xf6 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8e, .steppings =3D 0x0400, .driver_data =3D 0xf6 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8e, .steppings =3D 0x0800, .driver_data =3D 0xf6 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8e, .steppings =3D 0x1000, .driver_data =3D 0x100 =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8f, .steppings =3D 0x0010, .driver_data =3D 0x2c00=
03f7 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8f, .steppings =3D 0x0020, .driver_data =3D 0x2c00=
03f7 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8f, .steppings =3D 0x0040, .driver_data =3D 0x2c00=
03f7 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8f, .steppings =3D 0x0080, .driver_data =3D 0x2b00=
0639 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8f, .steppings =3D 0x0100, .driver_data =3D 0x2c00=
03f7 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x96, .steppings =3D 0x0002, .driver_data =3D 0x1a },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x97, .steppings =3D 0x0004, .driver_data =3D 0x3a },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x97, .steppings =3D 0x0020, .driver_data =3D 0x3a },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x9a, .steppings =3D 0x0008, .driver_data =3D 0x437 =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x9a, .steppings =3D 0x0010, .driver_data =3D 0x437 =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x9c, .steppings =3D 0x0001, .driver_data =3D 0x2400=
0026 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x9e, .steppings =3D 0x0200, .driver_data =3D 0xf8 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x9e, .steppings =3D 0x0400, .driver_data =3D 0xfa },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x9e, .steppings =3D 0x0800, .driver_data =3D 0xf6 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x9e, .steppings =3D 0x1000, .driver_data =3D 0xf8 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x9e, .steppings =3D 0x2000, .driver_data =3D 0x104 =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xa5, .steppings =3D 0x0004, .driver_data =3D 0x100 =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xa5, .steppings =3D 0x0008, .driver_data =3D 0x100 =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xa5, .steppings =3D 0x0020, .driver_data =3D 0x100 =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xa6, .steppings =3D 0x0001, .driver_data =3D 0x102 =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xa6, .steppings =3D 0x0002, .driver_data =3D 0x100 =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xa7, .steppings =3D 0x0002, .driver_data =3D 0x64 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xaa, .steppings =3D 0x0010, .driver_data =3D 0x24 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xad, .steppings =3D 0x0002, .driver_data =3D 0xa000=
0d1 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xaf, .steppings =3D 0x0008, .driver_data =3D 0x3000=
341 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xb5, .steppings =3D 0x0001, .driver_data =3D 0xa },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xb7, .steppings =3D 0x0002, .driver_data =3D 0x12f =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xb7, .steppings =3D 0x0010, .driver_data =3D 0x12f =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xba, .steppings =3D 0x0004, .driver_data =3D 0x4128=
 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xba, .steppings =3D 0x0008, .driver_data =3D 0x4128=
 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xba, .steppings =3D 0x0100, .driver_data =3D 0x4128=
 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xbd, .steppings =3D 0x0002, .driver_data =3D 0x11f =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xbe, .steppings =3D 0x0001, .driver_data =3D 0x1d },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xbf, .steppings =3D 0x0004, .driver_data =3D 0x3a },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xbf, .steppings =3D 0x0020, .driver_data =3D 0x3a },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xbf, .steppings =3D 0x0040, .driver_data =3D 0x3a },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xbf, .steppings =3D 0x0080, .driver_data =3D 0x3a },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xc5, .steppings =3D 0x0004, .driver_data =3D 0x118 =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xc6, .steppings =3D 0x0004, .driver_data =3D 0x118 =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xc6, .steppings =3D 0x0010, .driver_data =3D 0x118 =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xca, .steppings =3D 0x0004, .driver_data =3D 0x118 =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xcf, .steppings =3D 0x0002, .driver_data =3D 0x2100=
02a9 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xcf, .steppings =3D 0x0004, .driver_data =3D 0x2100=
02a9 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x00, .steppings =3D 0x0080, .driver_data =3D 0x12 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x00, .steppings =3D 0x0400, .driver_data =3D 0x15 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x01, .steppings =3D 0x0004, .driver_data =3D 0x2e },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x02, .steppings =3D 0x0010, .driver_data =3D 0x21 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x02, .steppings =3D 0x0020, .driver_data =3D 0x2c },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x02, .steppings =3D 0x0040, .driver_data =3D 0x10 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x02, .steppings =3D 0x0080, .driver_data =3D 0x39 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x02, .steppings =3D 0x0200, .driver_data =3D 0x2f },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x03, .steppings =3D 0x0004, .driver_data =3D 0xa },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x03, .steppings =3D 0x0008, .driver_data =3D 0xc },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x03, .steppings =3D 0x0010, .driver_data =3D 0x17 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x04, .steppings =3D 0x0002, .driver_data =3D 0x17 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x04, .steppings =3D 0x0008, .driver_data =3D 0x5 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x04, .steppings =3D 0x0010, .driver_data =3D 0x6 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x04, .steppings =3D 0x0080, .driver_data =3D 0x3 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x04, .steppings =3D 0x0100, .driver_data =3D 0xe },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x04, .steppings =3D 0x0200, .driver_data =3D 0x3 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x04, .steppings =3D 0x0400, .driver_data =3D 0x4 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x06, .steppings =3D 0x0004, .driver_data =3D 0xf },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x06, .steppings =3D 0x0010, .driver_data =3D 0x4 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x06, .steppings =3D 0x0020, .driver_data =3D 0x8 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x06, .steppings =3D 0x0100, .driver_data =3D 0x9 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x03, .steppings =3D 0x0004, .platform_mask =3D 0x00=
, .driver_data =3D 0x2 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x05, .steppings =3D 0x0001, .platform_mask =3D 0x01=
, .driver_data =3D 0x40 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x05, .steppings =3D 0x0001, .platform_mask =3D 0x02=
, .driver_data =3D 0x41 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x05, .steppings =3D 0x0001, .platform_mask =3D 0x08=
, .driver_data =3D 0x45 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x05, .steppings =3D 0x0002, .platform_mask =3D 0x01=
, .driver_data =3D 0x40 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x05, .steppings =3D 0x0004, .platform_mask =3D 0x01=
, .driver_data =3D 0x2a },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x05, .steppings =3D 0x0004, .platform_mask =3D 0x02=
, .driver_data =3D 0x2c },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x05, .steppings =3D 0x0004, .platform_mask =3D 0x04=
, .driver_data =3D 0x2b },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x05, .steppings =3D 0x0008, .platform_mask =3D 0x01=
, .driver_data =3D 0x10 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x05, .steppings =3D 0x0008, .platform_mask =3D 0x02=
, .driver_data =3D 0xc },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x05, .steppings =3D 0x0008, .platform_mask =3D 0x04=
, .driver_data =3D 0xb },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x05, .steppings =3D 0x0008, .platform_mask =3D 0x08=
, .driver_data =3D 0xd },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x06, .steppings =3D 0x0001, .platform_mask =3D 0x01=
, .driver_data =3D 0xa },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x06, .steppings =3D 0x0020, .platform_mask =3D 0x10=
, .driver_data =3D 0x3 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x06, .steppings =3D 0x0400, .platform_mask =3D 0x02=
, .driver_data =3D 0xc },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x06, .steppings =3D 0x0400, .platform_mask =3D 0x08=
, .driver_data =3D 0xd },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x06, .steppings =3D 0x0400, .platform_mask =3D 0x20=
, .driver_data =3D 0xb },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x06, .steppings =3D 0x2000, .platform_mask =3D 0x02=
, .driver_data =3D 0x5 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x06, .steppings =3D 0x2000, .platform_mask =3D 0x08=
, .driver_data =3D 0x6 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x06, .steppings =3D 0x2000, .platform_mask =3D 0x20=
, .driver_data =3D 0x7 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x07, .steppings =3D 0x0002, .platform_mask =3D 0x04=
, .driver_data =3D 0x14 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x07, .steppings =3D 0x0004, .platform_mask =3D 0x04=
, .driver_data =3D 0x38 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x07, .steppings =3D 0x0008, .platform_mask =3D 0x04=
, .driver_data =3D 0x2e },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x08, .steppings =3D 0x0002, .platform_mask =3D 0x01=
, .driver_data =3D 0xd },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x08, .steppings =3D 0x0002, .platform_mask =3D 0x04=
, .driver_data =3D 0x10 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x08, .steppings =3D 0x0002, .platform_mask =3D 0x08=
, .driver_data =3D 0xf },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x08, .steppings =3D 0x0002, .platform_mask =3D 0x10=
, .driver_data =3D 0x11 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x08, .steppings =3D 0x0002, .platform_mask =3D 0x20=
, .driver_data =3D 0xe },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x08, .steppings =3D 0x0008, .platform_mask =3D 0x08=
, .driver_data =3D 0x8 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x08, .steppings =3D 0x0008, .platform_mask =3D 0x20=
, .driver_data =3D 0x7 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x08, .steppings =3D 0x0040, .platform_mask =3D 0x01=
, .driver_data =3D 0x7 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x08, .steppings =3D 0x0040, .platform_mask =3D 0x02=
, .driver_data =3D 0xa },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x08, .steppings =3D 0x0040, .platform_mask =3D 0x04=
, .driver_data =3D 0x2 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x08, .steppings =3D 0x0040, .platform_mask =3D 0x10=
, .driver_data =3D 0x8 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x08, .steppings =3D 0x0040, .platform_mask =3D 0x80=
, .driver_data =3D 0xc },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x08, .steppings =3D 0x0400, .platform_mask =3D 0x10=
, .driver_data =3D 0x1 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x08, .steppings =3D 0x0400, .platform_mask =3D 0x20=
, .driver_data =3D 0x4 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x08, .steppings =3D 0x0400, .platform_mask =3D 0x80=
, .driver_data =3D 0x5 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x09, .steppings =3D 0x0020, .platform_mask =3D 0x10=
, .driver_data =3D 0x7 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x09, .steppings =3D 0x0020, .platform_mask =3D 0x20=
, .driver_data =3D 0x7 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x09, .steppings =3D 0x0020, .platform_mask =3D 0x80=
, .driver_data =3D 0x47 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0a, .steppings =3D 0x0001, .platform_mask =3D 0x04=
, .driver_data =3D 0x3 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0a, .steppings =3D 0x0002, .platform_mask =3D 0x04=
, .driver_data =3D 0x1 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0b, .steppings =3D 0x0002, .platform_mask =3D 0x10=
, .driver_data =3D 0x1c },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0b, .steppings =3D 0x0002, .platform_mask =3D 0x20=
, .driver_data =3D 0x1d },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0b, .steppings =3D 0x0010, .platform_mask =3D 0x10=
, .driver_data =3D 0x1 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0b, .steppings =3D 0x0010, .platform_mask =3D 0x20=
, .driver_data =3D 0x2 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0d, .steppings =3D 0x0040, .platform_mask =3D 0x20=
, .driver_data =3D 0x18 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0e, .steppings =3D 0x0100, .platform_mask =3D 0x20=
, .driver_data =3D 0x39 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0e, .steppings =3D 0x1000, .platform_mask =3D 0x20=
, .driver_data =3D 0x54 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0e, .steppings =3D 0x1000, .platform_mask =3D 0x80=
, .driver_data =3D 0x59 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0f, .steppings =3D 0x0004, .platform_mask =3D 0x01=
, .driver_data =3D 0x5d },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0f, .steppings =3D 0x0004, .platform_mask =3D 0x20=
, .driver_data =3D 0x5c },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0f, .steppings =3D 0x0040, .platform_mask =3D 0x01=
, .driver_data =3D 0xd0 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0f, .steppings =3D 0x0040, .platform_mask =3D 0x04=
, .driver_data =3D 0xd2 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0f, .steppings =3D 0x0040, .platform_mask =3D 0x20=
, .driver_data =3D 0xd1 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0f, .steppings =3D 0x0080, .platform_mask =3D 0x10=
, .driver_data =3D 0x6a },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0f, .steppings =3D 0x0080, .platform_mask =3D 0x40=
, .driver_data =3D 0x6b },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0f, .steppings =3D 0x0400, .platform_mask =3D 0x80=
, .driver_data =3D 0x95 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0f, .steppings =3D 0x0800, .platform_mask =3D 0x01=
, .driver_data =3D 0xba },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0f, .steppings =3D 0x0800, .platform_mask =3D 0x04=
, .driver_data =3D 0xbc },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0f, .steppings =3D 0x0800, .platform_mask =3D 0x08=
, .driver_data =3D 0xbb },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0f, .steppings =3D 0x0800, .platform_mask =3D 0x10=
, .driver_data =3D 0xba },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0f, .steppings =3D 0x0800, .platform_mask =3D 0x20=
, .driver_data =3D 0xba },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0f, .steppings =3D 0x0800, .platform_mask =3D 0x40=
, .driver_data =3D 0xbc },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0f, .steppings =3D 0x0800, .platform_mask =3D 0x80=
, .driver_data =3D 0xba },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0f, .steppings =3D 0x2000, .platform_mask =3D 0x01=
, .driver_data =3D 0xa4 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0f, .steppings =3D 0x2000, .platform_mask =3D 0x20=
, .driver_data =3D 0xa4 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x0f, .steppings =3D 0x2000, .platform_mask =3D 0x80=
, .driver_data =3D 0xa4 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x16, .steppings =3D 0x0002, .platform_mask =3D 0x01=
, .driver_data =3D 0x43 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x16, .steppings =3D 0x0002, .platform_mask =3D 0x02=
, .driver_data =3D 0x42 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x16, .steppings =3D 0x0002, .platform_mask =3D 0x80=
, .driver_data =3D 0x44 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x17, .steppings =3D 0x0040, .platform_mask =3D 0x01=
, .driver_data =3D 0x60f },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x17, .steppings =3D 0x0040, .platform_mask =3D 0x04=
, .driver_data =3D 0x60f },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x17, .steppings =3D 0x0040, .platform_mask =3D 0x10=
, .driver_data =3D 0x60f },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x17, .steppings =3D 0x0040, .platform_mask =3D 0x40=
, .driver_data =3D 0x60f },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x17, .steppings =3D 0x0040, .platform_mask =3D 0x80=
, .driver_data =3D 0x60f },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x17, .steppings =3D 0x0080, .platform_mask =3D 0x10=
, .driver_data =3D 0x70a },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x17, .steppings =3D 0x0400, .platform_mask =3D 0x11=
, .driver_data =3D 0xa0b },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x17, .steppings =3D 0x0400, .platform_mask =3D 0x44=
, .driver_data =3D 0xa0b },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x17, .steppings =3D 0x0400, .platform_mask =3D 0xa0=
, .driver_data =3D 0xa0b },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x1a, .steppings =3D 0x0010, .platform_mask =3D 0x03=
, .driver_data =3D 0x12 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x1a, .steppings =3D 0x0020, .platform_mask =3D 0x03=
, .driver_data =3D 0x1d },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x1c, .steppings =3D 0x0004, .platform_mask =3D 0x01=
, .driver_data =3D 0x217 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x1c, .steppings =3D 0x0004, .platform_mask =3D 0x04=
, .driver_data =3D 0x218 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x1c, .steppings =3D 0x0004, .platform_mask =3D 0x08=
, .driver_data =3D 0x219 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x1c, .steppings =3D 0x0400, .platform_mask =3D 0x01=
, .driver_data =3D 0x107 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x1c, .steppings =3D 0x0400, .platform_mask =3D 0x04=
, .driver_data =3D 0x107 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x1c, .steppings =3D 0x0400, .platform_mask =3D 0x08=
, .driver_data =3D 0x107 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x1c, .steppings =3D 0x0400, .platform_mask =3D 0x10=
, .driver_data =3D 0x107 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x1d, .steppings =3D 0x0002, .platform_mask =3D 0x08=
, .driver_data =3D 0x29 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x1e, .steppings =3D 0x0020, .platform_mask =3D 0x13=
, .driver_data =3D 0xa },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x25, .steppings =3D 0x0004, .platform_mask =3D 0x12=
, .driver_data =3D 0x11 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x25, .steppings =3D 0x0020, .platform_mask =3D 0x92=
, .driver_data =3D 0x7 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x26, .steppings =3D 0x0002, .platform_mask =3D 0x01=
, .driver_data =3D 0x104 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x26, .steppings =3D 0x0002, .platform_mask =3D 0x02=
, .driver_data =3D 0x105 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x2a, .steppings =3D 0x0080, .platform_mask =3D 0x12=
, .driver_data =3D 0x2f },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x2c, .steppings =3D 0x0004, .platform_mask =3D 0x03=
, .driver_data =3D 0x1f },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x2d, .steppings =3D 0x0040, .platform_mask =3D 0x6d=
, .driver_data =3D 0x621 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x2d, .steppings =3D 0x0080, .platform_mask =3D 0x6d=
, .driver_data =3D 0x71a },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x2e, .steppings =3D 0x0040, .platform_mask =3D 0x04=
, .driver_data =3D 0xd },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x2f, .steppings =3D 0x0004, .platform_mask =3D 0x05=
, .driver_data =3D 0x3b },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x37, .steppings =3D 0x0100, .platform_mask =3D 0x02=
, .driver_data =3D 0x838 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x37, .steppings =3D 0x0100, .platform_mask =3D 0x0c=
, .driver_data =3D 0x838 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x37, .steppings =3D 0x0200, .platform_mask =3D 0x0f=
, .driver_data =3D 0x90d },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x3a, .steppings =3D 0x0200, .platform_mask =3D 0x12=
, .driver_data =3D 0x21 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x3c, .steppings =3D 0x0008, .platform_mask =3D 0x32=
, .driver_data =3D 0x28 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x3d, .steppings =3D 0x0010, .platform_mask =3D 0xc0=
, .driver_data =3D 0x2f },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x3e, .steppings =3D 0x0010, .platform_mask =3D 0xed=
, .driver_data =3D 0x42e },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x3e, .steppings =3D 0x0040, .platform_mask =3D 0xed=
, .driver_data =3D 0x600 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x3e, .steppings =3D 0x0080, .platform_mask =3D 0xed=
, .driver_data =3D 0x715 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x3f, .steppings =3D 0x0004, .platform_mask =3D 0x6f=
, .driver_data =3D 0x49 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x3f, .steppings =3D 0x0010, .platform_mask =3D 0x80=
, .driver_data =3D 0x1a },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x45, .steppings =3D 0x0002, .platform_mask =3D 0x72=
, .driver_data =3D 0x26 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x46, .steppings =3D 0x0002, .platform_mask =3D 0x32=
, .driver_data =3D 0x1c },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x47, .steppings =3D 0x0002, .platform_mask =3D 0x22=
, .driver_data =3D 0x22 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x4c, .steppings =3D 0x0008, .platform_mask =3D 0x01=
, .driver_data =3D 0x368 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x4c, .steppings =3D 0x0010, .platform_mask =3D 0x01=
, .driver_data =3D 0x411 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x4d, .steppings =3D 0x0100, .platform_mask =3D 0x01=
, .driver_data =3D 0x12d },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x4e, .steppings =3D 0x0008, .platform_mask =3D 0xc0=
, .driver_data =3D 0xf0 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x55, .steppings =3D 0x0008, .platform_mask =3D 0x97=
, .driver_data =3D 0x1000191 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x55, .steppings =3D 0x0010, .platform_mask =3D 0xb7=
, .driver_data =3D 0x2007006 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x55, .steppings =3D 0x0020, .platform_mask =3D 0xb7=
, .driver_data =3D 0x3000010 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x55, .steppings =3D 0x0080, .platform_mask =3D 0xbf=
, .driver_data =3D 0x5003901 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x55, .steppings =3D 0x0800, .platform_mask =3D 0xbf=
, .driver_data =3D 0x7002b01 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x56, .steppings =3D 0x0004, .platform_mask =3D 0x10=
, .driver_data =3D 0x1c },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x56, .steppings =3D 0x0008, .platform_mask =3D 0x10=
, .driver_data =3D 0x700001c },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x56, .steppings =3D 0x0010, .platform_mask =3D 0x10=
, .driver_data =3D 0xf00001a },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x56, .steppings =3D 0x0020, .platform_mask =3D 0x10=
, .driver_data =3D 0xe000015 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x5c, .steppings =3D 0x0004, .platform_mask =3D 0x01=
, .driver_data =3D 0x14 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x5c, .steppings =3D 0x0200, .platform_mask =3D 0x03=
, .driver_data =3D 0x48 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x5c, .steppings =3D 0x0400, .platform_mask =3D 0x03=
, .driver_data =3D 0x28 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x5e, .steppings =3D 0x0008, .platform_mask =3D 0x36=
, .driver_data =3D 0xf0 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x5f, .steppings =3D 0x0002, .platform_mask =3D 0x01=
, .driver_data =3D 0x3e },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x66, .steppings =3D 0x0008, .platform_mask =3D 0x80=
, .driver_data =3D 0x2a },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x6a, .steppings =3D 0x0020, .platform_mask =3D 0x87=
, .driver_data =3D 0xc0002f0 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x6a, .steppings =3D 0x0040, .platform_mask =3D 0x87=
, .driver_data =3D 0xd000404 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x6c, .steppings =3D 0x0002, .platform_mask =3D 0x10=
, .driver_data =3D 0x10002d0 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x7a, .steppings =3D 0x0002, .platform_mask =3D 0x01=
, .driver_data =3D 0x42 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x7a, .steppings =3D 0x0100, .platform_mask =3D 0x01=
, .driver_data =3D 0x26 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x7e, .steppings =3D 0x0020, .platform_mask =3D 0x80=
, .driver_data =3D 0xca },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8a, .steppings =3D 0x0002, .platform_mask =3D 0x10=
, .driver_data =3D 0x33 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8c, .steppings =3D 0x0002, .platform_mask =3D 0x80=
, .driver_data =3D 0xbc },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8c, .steppings =3D 0x0004, .platform_mask =3D 0xc2=
, .driver_data =3D 0x3c },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8d, .steppings =3D 0x0002, .platform_mask =3D 0xc2=
, .driver_data =3D 0x56 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8e, .steppings =3D 0x0200, .platform_mask =3D 0x10=
, .driver_data =3D 0xf6 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8e, .steppings =3D 0x0200, .platform_mask =3D 0xc0=
, .driver_data =3D 0xf6 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8e, .steppings =3D 0x0400, .platform_mask =3D 0xc0=
, .driver_data =3D 0xf6 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8e, .steppings =3D 0x0800, .platform_mask =3D 0xd0=
, .driver_data =3D 0xf6 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8e, .steppings =3D 0x1000, .platform_mask =3D 0x94=
, .driver_data =3D 0x100 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8f, .steppings =3D 0x0010, .platform_mask =3D 0x10=
, .driver_data =3D 0x2c0003f7 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8f, .steppings =3D 0x0010, .platform_mask =3D 0x87=
, .driver_data =3D 0x2b000639 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8f, .steppings =3D 0x0020, .platform_mask =3D 0x10=
, .driver_data =3D 0x2c0003f7 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8f, .steppings =3D 0x0020, .platform_mask =3D 0x87=
, .driver_data =3D 0x2b000639 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8f, .steppings =3D 0x0040, .platform_mask =3D 0x10=
, .driver_data =3D 0x2c0003f7 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8f, .steppings =3D 0x0040, .platform_mask =3D 0x87=
, .driver_data =3D 0x2b000639 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8f, .steppings =3D 0x0080, .platform_mask =3D 0x87=
, .driver_data =3D 0x2b000639 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8f, .steppings =3D 0x0100, .platform_mask =3D 0x10=
, .driver_data =3D 0x2c0003f7 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8f, .steppings =3D 0x0100, .platform_mask =3D 0x87=
, .driver_data =3D 0x2b000639 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x96, .steppings =3D 0x0002, .platform_mask =3D 0x01=
, .driver_data =3D 0x1a },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x97, .steppings =3D 0x0004, .platform_mask =3D 0x07=
, .driver_data =3D 0x3a },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x97, .steppings =3D 0x0020, .platform_mask =3D 0x07=
, .driver_data =3D 0x3a },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x9a, .steppings =3D 0x0008, .platform_mask =3D 0x80=
, .driver_data =3D 0x437 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x9a, .steppings =3D 0x0010, .platform_mask =3D 0x40=
, .driver_data =3D 0xa },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x9a, .steppings =3D 0x0010, .platform_mask =3D 0x80=
, .driver_data =3D 0x437 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x9c, .steppings =3D 0x0001, .platform_mask =3D 0x01=
, .driver_data =3D 0x24000026 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x9e, .steppings =3D 0x0200, .platform_mask =3D 0x2a=
, .driver_data =3D 0xf8 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x9e, .steppings =3D 0x0400, .platform_mask =3D 0x22=
, .driver_data =3D 0xfa },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x9e, .steppings =3D 0x0800, .platform_mask =3D 0x02=
, .driver_data =3D 0xf6 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x9e, .steppings =3D 0x1000, .platform_mask =3D 0x22=
, .driver_data =3D 0xf8 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x9e, .steppings =3D 0x2000, .platform_mask =3D 0x22=
, .driver_data =3D 0x104 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xa5, .steppings =3D 0x0004, .platform_mask =3D 0x20=
, .driver_data =3D 0x100 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xa5, .steppings =3D 0x0008, .platform_mask =3D 0x22=
, .driver_data =3D 0x100 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xa5, .steppings =3D 0x0020, .platform_mask =3D 0x22=
, .driver_data =3D 0x100 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xa6, .steppings =3D 0x0001, .platform_mask =3D 0x80=
, .driver_data =3D 0x102 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xa6, .steppings =3D 0x0002, .platform_mask =3D 0x80=
, .driver_data =3D 0x100 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xa7, .steppings =3D 0x0002, .platform_mask =3D 0x02=
, .driver_data =3D 0x64 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xaa, .steppings =3D 0x0010, .platform_mask =3D 0xe6=
, .driver_data =3D 0x24 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xad, .steppings =3D 0x0002, .platform_mask =3D 0x20=
, .driver_data =3D 0xa0000d1 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xad, .steppings =3D 0x0002, .platform_mask =3D 0x95=
, .driver_data =3D 0x10003a2 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xaf, .steppings =3D 0x0008, .platform_mask =3D 0x01=
, .driver_data =3D 0x3000341 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xb5, .steppings =3D 0x0001, .platform_mask =3D 0x80=
, .driver_data =3D 0xa },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xb7, .steppings =3D 0x0002, .platform_mask =3D 0x32=
, .driver_data =3D 0x12f },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xb7, .steppings =3D 0x0010, .platform_mask =3D 0x32=
, .driver_data =3D 0x12f },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xba, .steppings =3D 0x0004, .platform_mask =3D 0xe0=
, .driver_data =3D 0x4128 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xba, .steppings =3D 0x0008, .platform_mask =3D 0xe0=
, .driver_data =3D 0x4128 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xba, .steppings =3D 0x0100, .platform_mask =3D 0xe0=
, .driver_data =3D 0x4128 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xbd, .steppings =3D 0x0002, .platform_mask =3D 0x80=
, .driver_data =3D 0x11f },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xbe, .steppings =3D 0x0001, .platform_mask =3D 0x19=
, .driver_data =3D 0x1d },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xbf, .steppings =3D 0x0004, .platform_mask =3D 0x07=
, .driver_data =3D 0x3a },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xbf, .steppings =3D 0x0020, .platform_mask =3D 0x07=
, .driver_data =3D 0x3a },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xbf, .steppings =3D 0x0040, .platform_mask =3D 0x07=
, .driver_data =3D 0x3a },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xbf, .steppings =3D 0x0080, .platform_mask =3D 0x07=
, .driver_data =3D 0x3a },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xc5, .steppings =3D 0x0004, .platform_mask =3D 0x82=
, .driver_data =3D 0x118 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xc6, .steppings =3D 0x0004, .platform_mask =3D 0x82=
, .driver_data =3D 0x118 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xc6, .steppings =3D 0x0010, .platform_mask =3D 0x82=
, .driver_data =3D 0x118 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xca, .steppings =3D 0x0004, .platform_mask =3D 0x82=
, .driver_data =3D 0x118 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xcf, .steppings =3D 0x0002, .platform_mask =3D 0x87=
, .driver_data =3D 0x210002a9 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xcf, .steppings =3D 0x0004, .platform_mask =3D 0x87=
, .driver_data =3D 0x210002a9 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x00, .steppings =3D 0x0080, .platform_mask =3D 0x01=
, .driver_data =3D 0x12 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x00, .steppings =3D 0x0080, .platform_mask =3D 0x02=
, .driver_data =3D 0x8 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x00, .steppings =3D 0x0400, .platform_mask =3D 0x01=
, .driver_data =3D 0x13 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x00, .steppings =3D 0x0400, .platform_mask =3D 0x02=
, .driver_data =3D 0x15 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x00, .steppings =3D 0x0400, .platform_mask =3D 0x04=
, .driver_data =3D 0x14 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x01, .steppings =3D 0x0004, .platform_mask =3D 0x04=
, .driver_data =3D 0x2e },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x02, .steppings =3D 0x0010, .platform_mask =3D 0x02=
, .driver_data =3D 0x1f },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x02, .steppings =3D 0x0010, .platform_mask =3D 0x04=
, .driver_data =3D 0x1e },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x02, .steppings =3D 0x0010, .platform_mask =3D 0x10=
, .driver_data =3D 0x21 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x02, .steppings =3D 0x0020, .platform_mask =3D 0x01=
, .driver_data =3D 0x29 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x02, .steppings =3D 0x0020, .platform_mask =3D 0x02=
, .driver_data =3D 0x2a },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x02, .steppings =3D 0x0020, .platform_mask =3D 0x04=
, .driver_data =3D 0x2b },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x02, .steppings =3D 0x0020, .platform_mask =3D 0x10=
, .driver_data =3D 0x2c },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x02, .steppings =3D 0x0040, .platform_mask =3D 0x02=
, .driver_data =3D 0x10 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x02, .steppings =3D 0x0080, .platform_mask =3D 0x02=
, .driver_data =3D 0x38 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x02, .steppings =3D 0x0080, .platform_mask =3D 0x04=
, .driver_data =3D 0x37 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x02, .steppings =3D 0x0080, .platform_mask =3D 0x08=
, .driver_data =3D 0x39 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x02, .steppings =3D 0x0200, .platform_mask =3D 0x02=
, .driver_data =3D 0x2d },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x02, .steppings =3D 0x0200, .platform_mask =3D 0x04=
, .driver_data =3D 0x2e },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x02, .steppings =3D 0x0200, .platform_mask =3D 0x08=
, .driver_data =3D 0x2f },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x03, .steppings =3D 0x0004, .platform_mask =3D 0x0d=
, .driver_data =3D 0xa },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x03, .steppings =3D 0x0008, .platform_mask =3D 0x0d=
, .driver_data =3D 0xc },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x03, .steppings =3D 0x0010, .platform_mask =3D 0x1d=
, .driver_data =3D 0x17 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x04, .steppings =3D 0x0002, .platform_mask =3D 0x02=
, .driver_data =3D 0x16 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x04, .steppings =3D 0x0002, .platform_mask =3D 0xbd=
, .driver_data =3D 0x17 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x04, .steppings =3D 0x0008, .platform_mask =3D 0x9d=
, .driver_data =3D 0x5 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x04, .steppings =3D 0x0010, .platform_mask =3D 0x9d=
, .driver_data =3D 0x6 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x04, .steppings =3D 0x0080, .platform_mask =3D 0x9d=
, .driver_data =3D 0x3 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x04, .steppings =3D 0x0100, .platform_mask =3D 0x01=
, .driver_data =3D 0xc },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x04, .steppings =3D 0x0100, .platform_mask =3D 0x02=
, .driver_data =3D 0xe },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x04, .steppings =3D 0x0100, .platform_mask =3D 0x5f=
, .driver_data =3D 0x7 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x04, .steppings =3D 0x0200, .platform_mask =3D 0xbd=
, .driver_data =3D 0x3 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x04, .steppings =3D 0x0400, .platform_mask =3D 0x5c=
, .driver_data =3D 0x4 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x04, .steppings =3D 0x0400, .platform_mask =3D 0x5d=
, .driver_data =3D 0x2 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x06, .steppings =3D 0x0004, .platform_mask =3D 0x04=
, .driver_data =3D 0xf },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x06, .steppings =3D 0x0010, .platform_mask =3D 0x01=
, .driver_data =3D 0x2 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x06, .steppings =3D 0x0010, .platform_mask =3D 0x34=
, .driver_data =3D 0x4 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x06, .steppings =3D 0x0020, .platform_mask =3D 0x01=
, .driver_data =3D 0x8 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x06, .steppings =3D 0x0100, .platform_mask =3D 0x22=
, .driver_data =3D 0x9 },

