Return-Path: <linux-tip-commits+bounces-8261-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPHdMh19n2mrcQQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8261-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Feb 2026 23:52:13 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B88419E793
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Feb 2026 23:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 799A930792FB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Feb 2026 22:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053F136657E;
	Wed, 25 Feb 2026 22:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PKtPpqyT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NYFWRMux"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9A71E5B63;
	Wed, 25 Feb 2026 22:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772059886; cv=none; b=ttkW8/i1imPWbCG4Eog+SwC2dCCpkKpEYUM7K5h6xg4EQW0tG1KQx5iGMZNQkol1inrNgbCJ1O/6/m4LQKGLhXwkrjjYKAc5OHa6MOTx/eDxfJCYoRAXN6560CTTErhLN95MsHXutKmj10k2K2WHQfpCf2hI8VOPfPhDYf8fwU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772059886; c=relaxed/simple;
	bh=mJlxjkMLraNz7CcIJmuskIvy9nBvb2c+enhTRHXXxxU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PsRyKIe5NxFjHw6av/vAdyt+QhxSr0sidQW2Bpd27OYWdJi1k5q0iNH9NuqAPEN3wOkS4egwnz/1ypr2jrl4+zRa2Dy8ec0O4Yib7I/ExiWke4rS8/ptE40mWpbDw11gARwA3+Hk+24dXCy4AYR6ezn+Sw45eqDZ1qnSnbFwkv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PKtPpqyT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NYFWRMux; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 25 Feb 2026 22:51:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772059884;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJYmy6cMhPj/yLpEyfp110sX6FhME/nW5LeMKJ2YZA8=;
	b=PKtPpqyTuUoP3jz9SoChvOtWdNyHcQT8Gkt9FImA1LAt0LHxU/xfRSolv+g6J+Vu5kLalS
	hFI2/ahAwqEfcCqpbsvQ3S/Eh3+CL3hkhnCIt0XcOvcq6eW/TlFN42W4Nz/dZtgN/dpp1U
	350WMJkeRIIgDto6USP6fBqCx5+MPBglxXd6oky0ZJKFhiHEQExICYNfUf7MuSN5EP9d07
	t1Yl/j8AIVvra5wwHeU1X7xreRfv98HY+0iDnC+f+AcbGkWtXUqgwjqRtQtZNVo0jnIWq4
	yRW/1HCX0vIqjyM6N0pcl2ewrDyjXkFLo/a85EcpBTIWHaJqiclw3SSrCZkKng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772059884;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJYmy6cMhPj/yLpEyfp110sX6FhME/nW5LeMKJ2YZA8=;
	b=NYFWRMuxwddrcp/90k+EGCR8O5DqxP7LLQ7M54Wj7/XdpqurJqsL393558VZt47Gu7JZ8U
	MDNDOALHCZL41uAA==
From: "tip-bot2 for Vishal Verma" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/virt/tdx: Print TDX module version during init
Cc: Vishal Verma <vishal.l.verma@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Chao Gao <chao.gao@intel.com>,
 Tony Lindgren <tony.lindgren@linux.intel.com>,
 Kiryl Shutsemau <kas@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, Kai Huang <kai.huang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260109-tdx_print_module_version-v2-2-e10e4ca5b450@intel.com>
References: <20260109-tdx_print_module_version-v2-2-e10e4ca5b450@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177205988262.1647592.7146621901155081439.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8261-lists,linux-tip-commits=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,vger.kernel.org:replyto]
X-Rspamd-Queue-Id: 2B88419E793
X-Rspamd-Action: no action

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     b5425f5406ee1b4bd84720f68020ef18ce380bab
Gitweb:        https://git.kernel.org/tip/b5425f5406ee1b4bd84720f68020ef18ce3=
80bab
Author:        Vishal Verma <vishal.l.verma@intel.com>
AuthorDate:    Fri, 09 Jan 2026 12:14:31 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 25 Feb 2026 14:46:33 -08:00

x86/virt/tdx: Print TDX module version during init

It is useful to print the TDX module version in dmesg logs. This is
currently the only way to determine the module version from the host. It
also creates a record for any future problems being investigated. This
was also requested in [1].

Include the version in the log messages during init, e.g.:

  virt/tdx: TDX module version: 1.5.24
  virt/tdx: 1034220 KB allocated for PAMT
  virt/tdx: module initialized

Print the version in get_tdx_sys_info(), right after the version
metadata is read, which makes it available even if there are subsequent
initialization failures.

Based on a patch by Kai Huang <kai.huang@intel.com> [2]

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Kiryl Shutsemau <kas@kernel.org>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Link: https://lore.kernel.org/all/CAGtprH8eXwi-TcH2+-Fo5YdbEwGmgLBh9ggcDvd6N=
=3DbsKEJ_WQ@mail.gmail.com/ # [1]
Link: https://lore.kernel.org/all/6b5553756f56a8e3222bfc36d0bdb3e5192137b7.17=
31318868.git.kai.huang@intel.com # [2]
Link: https://patch.msgid.link/20260109-tdx_print_module_version-v2-2-e10e4ca=
5b450@intel.com
---
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/=
tdx/tdx_global_metadata.c
index 0454124..4c9917a 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -105,6 +105,12 @@ static int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 	int ret =3D 0;
=20
 	ret =3D ret ?: get_tdx_sys_info_version(&sysinfo->version);
+
+	pr_info("Module version: %u.%u.%02u\n",
+		sysinfo->version.major_version,
+		sysinfo->version.minor_version,
+		sysinfo->version.update_version);
+
 	ret =3D ret ?: get_tdx_sys_info_features(&sysinfo->features);
 	ret =3D ret ?: get_tdx_sys_info_tdmr(&sysinfo->tdmr);
 	ret =3D ret ?: get_tdx_sys_info_td_ctrl(&sysinfo->td_ctrl);

