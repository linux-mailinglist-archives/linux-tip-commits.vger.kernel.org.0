Return-Path: <linux-tip-commits+bounces-8347-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Da1IMl4p2kshwAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8347-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 01:11:53 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D201F8C12
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 01:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A95E8305F4FC
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Mar 2026 00:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884E024BBF4;
	Wed,  4 Mar 2026 00:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zyC2Jy0G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sy8lE7uT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFD71C5D5E;
	Wed,  4 Mar 2026 00:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772583016; cv=none; b=kRh3WrTBggucVTjx/pd0UijmwZkdUboTlJcysdwceRuXoefNyFrTW6qQ5P+JqMhrlBXqlAvRl6LcWlA77YOPJaJ0WgcPRD96xGEFLygWLkrvripZe4ZUFAkzPLGmwjl1NdsU2grzz7gpw+rJWt446JK2MZceaTF2X8BxlJxJec0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772583016; c=relaxed/simple;
	bh=WSrMtGeQDTMPOq+w98QHI1wLoadGoBuPeEHErFEAZKY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ly1ocmwOYIdsdO1JTd2XTe3nbWBH2puTYnKh5xc3U16fo1v0oAxdPwmSDKzt2lZ8vM3V3LeDZsKz4AL7vmEznZT8BNYdaA4FFDTt39/3d2M9bJ2zJR8t2zTyFd3LbpwKylqDm6KkHfOAVsLhMno/9DAnWO+rdmrwxzCG+PGfhK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zyC2Jy0G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sy8lE7uT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Mar 2026 00:10:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772583013;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EmMeAq4K0aSjBSkME40JTUVHeoQSxyZu44ZhPve5Sag=;
	b=zyC2Jy0G1ZAz0kCrf14KItPeRCloJJ0eL4WZ0G50bFyTSn31TktZk90w01PnnTtsErtNDe
	1Vvobm3XYJtiOKimufvWW0SVFp5h3i3wyn5P/CCRvPj0FPkIAh3mchiuFTZI4aTMy6XkLO
	C7YRxkxdW1N27GYwMWOWEQZydoqPGiZVe5nrLuqSVm6Xwj1cvnFa3CWLY0W5cPavYq8J77
	W+XyLVkQwSKScTA4GY0jPUBu3gfreiiZ2I79hJWUOff/inabAy20x6hmpNag9iiJSFSIFo
	DjhQodnKbqZ2DRjtrm5SUGSqp5dX7o5FVLsbfZ+lbhhL5UP0zNL9kP9AhAYEfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772583013;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EmMeAq4K0aSjBSkME40JTUVHeoQSxyZu44ZhPve5Sag=;
	b=Sy8lE7uTh3r4D58kW6HeJWcM0pJfE7ZWpHin14nuNGFPPFuVc8QM0RLm+l3igmO5F0Jqsu
	M2WvmBL4CXcOqtDw==
From: "tip-bot2 for Xiaoyao Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Fix the typo in TDX_ATTR_MIGRTABLE
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Sean Christopherson <seanjc@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260303030335.766779-2-xiaoyao.li@intel.com>
References: <20260303030335.766779-2-xiaoyao.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177258301238.1647592.5543002142198411843.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E3D201F8C12
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
	TAGGED_FROM(0.00)[bounces-8347-lists,linux-tip-commits=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linutronix.de:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,vger.kernel.org:replyto]
X-Rspamd-Action: no action

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     3aecb2e7b948400354399b26f3f1653bd2c1bae0
Gitweb:        https://git.kernel.org/tip/3aecb2e7b948400354399b26f3f1653bd2c=
1bae0
Author:        Xiaoyao Li <xiaoyao.li@intel.com>
AuthorDate:    Tue, 03 Mar 2026 11:03:32 +08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 03 Mar 2026 16:06:49 -08:00

x86/tdx: Fix the typo in TDX_ATTR_MIGRTABLE

The TD scoped TDCS attributes are defined by bit positions. In the guest
side of the TDX code, the 'tdx_attributes' string array holds pretty
print names for these attributes, which are generated via macros and
defines. Today these pretty print names are only used to print the
attribute names to dmesg.

Unfortunately there is a typo in the define for the migratable bit.
Change the defines TDX_ATTR_MIGRTABLE* to TDX_ATTR_MIGRATABLE*. Update
the sole user, the tdx_attributes array, to use the fixed name.

Since these defines control the string printed to dmesg, the change is
user visible. But the risk of breakage is almost zero since it is not
exposed in any interface expected to be consumed programmatically.

Fixes: 564ea84c8c14 ("x86/tdx: Dump attributes and TD_CTLS on boot")
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://patch.msgid.link/20260303030335.766779-2-xiaoyao.li@intel.com
---
 arch/x86/coco/tdx/debug.c         | 2 +-
 arch/x86/include/asm/shared/tdx.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/coco/tdx/debug.c b/arch/x86/coco/tdx/debug.c
index cef847c..28990c2 100644
--- a/arch/x86/coco/tdx/debug.c
+++ b/arch/x86/coco/tdx/debug.c
@@ -17,7 +17,7 @@ static __initdata const char *tdx_attributes[] =3D {
 	DEF_TDX_ATTR_NAME(ICSSD),
 	DEF_TDX_ATTR_NAME(LASS),
 	DEF_TDX_ATTR_NAME(SEPT_VE_DISABLE),
-	DEF_TDX_ATTR_NAME(MIGRTABLE),
+	DEF_TDX_ATTR_NAME(MIGRATABLE),
 	DEF_TDX_ATTR_NAME(PKS),
 	DEF_TDX_ATTR_NAME(KL),
 	DEF_TDX_ATTR_NAME(TPA),
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/=
tdx.h
index 8bc074c..11f3cf3 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -35,8 +35,8 @@
 #define TDX_ATTR_LASS			BIT_ULL(TDX_ATTR_LASS_BIT)
 #define TDX_ATTR_SEPT_VE_DISABLE_BIT	28
 #define TDX_ATTR_SEPT_VE_DISABLE	BIT_ULL(TDX_ATTR_SEPT_VE_DISABLE_BIT)
-#define TDX_ATTR_MIGRTABLE_BIT		29
-#define TDX_ATTR_MIGRTABLE		BIT_ULL(TDX_ATTR_MIGRTABLE_BIT)
+#define TDX_ATTR_MIGRATABLE_BIT		29
+#define TDX_ATTR_MIGRATABLE		BIT_ULL(TDX_ATTR_MIGRATABLE_BIT)
 #define TDX_ATTR_PKS_BIT		30
 #define TDX_ATTR_PKS			BIT_ULL(TDX_ATTR_PKS_BIT)
 #define TDX_ATTR_KL_BIT			31

