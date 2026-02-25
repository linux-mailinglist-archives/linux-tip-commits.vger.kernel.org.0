Return-Path: <linux-tip-commits+bounces-8262-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KO/MAvV8n2mrcQQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8262-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Feb 2026 23:51:33 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D75019E783
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Feb 2026 23:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A354300E1A0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Feb 2026 22:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9004366DBA;
	Wed, 25 Feb 2026 22:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1XJxQ93G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/50Wj0GD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE08366060;
	Wed, 25 Feb 2026 22:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772059887; cv=none; b=LRQOQo3bKuuY4PWKOJKc8qLfu8ZTN+H2cgC0TccR5bXiiuSgWHgjYuZjaJbvPonDHHINZmU0omUO3F/90FN7yYeeOpEgw8rhd0PI2vvJqLPcZ0bcTgVUYOz8NDjoJAJ+ePKMhlN7QWK1eToGpbA8m+dBkfJN2n/L/N1HQJQdvAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772059887; c=relaxed/simple;
	bh=0DNkMcps4kzpa8qa6htdPE1NusZJoHUXu9B2HcXjEBU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=brUgsWN2Vd7CtzKlBRESYC3kEJjcANxweTWOuJOucxsIa5VpKKtvtuLWiCgrF9kOfuKJwQYamgWRW9b5pHBZsj+d6760I9SQuvTLHGlIg63f0fSrEBeAtMv0DbCmKDO7AWBK9NgQdQC1albXXxqaa/T3pK05AQTO4WgAJkVDTKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1XJxQ93G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/50Wj0GD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 25 Feb 2026 22:51:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772059885;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZWhjhNI9NSVPep8dmWgriiLzemTxdlcV4sW0ae9e9UM=;
	b=1XJxQ93GrCZZxppHRgs2aYxKY3CQT9Adml1/4LPCHwgOW7ALzTnNz6KsUXgJNyRfL+6GJq
	iP68XJFDua8sh1ibjSR4nZI0H5JaapAhmFMGwiQiEAtNbpNibxP5fDcWPKxckkyu1bXr/G
	jInJuyNNQz7wALQrq4vqEEEjQTxAtMixp0mYO/l7c1tngiX2VU6FRZN5gNltiUgj8PqSu/
	W77kpaGcwbcKMYPGsXPd72kmvCKp+x6VvWSHtaEsUneiKmBWfI0+LmU1Y4dY+PlAfxBf0p
	9rZJQVWaehYRuk5P6CRHbpBQk+zeEZawh/l4RNFXeAAEGbLTlxXQVNnrqSXggw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772059885;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZWhjhNI9NSVPep8dmWgriiLzemTxdlcV4sW0ae9e9UM=;
	b=/50Wj0GDa2nlwG5IsRz2MqH4U1R4ArPw9gJHnrGwb9d1P5RiPrbNDsgRNjdaWIYLCeV9yM
	//JChi5wltGWVOCw==
From: "tip-bot2 for Chao Gao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/virt/tdx: Retrieve TDX module version
Cc: Chao Gao <chao.gao@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>,
 Tony Lindgren <tony.lindgren@linux.intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Kai Huang <kai.huang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260109-tdx_print_module_version-v2-1-e10e4ca5b450@intel.com>
References: <20260109-tdx_print_module_version-v2-1-e10e4ca5b450@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177205988369.1647592.3727466626745247526.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
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
	TAGGED_FROM(0.00)[bounces-8262-lists,linux-tip-commits=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,vger.kernel.org:replyto]
X-Rspamd-Queue-Id: 2D75019E783
X-Rspamd-Action: no action

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     311214bf1df4b110f6b0646615aecfab388a25ef
Gitweb:        https://git.kernel.org/tip/311214bf1df4b110f6b0646615aecfab388=
a25ef
Author:        Chao Gao <chao.gao@intel.com>
AuthorDate:    Fri, 09 Jan 2026 12:14:30 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 25 Feb 2026 14:46:33 -08:00

x86/virt/tdx: Retrieve TDX module version

Each TDX module has several bits of metadata about which specific TDX
module it is. The primary bit of info is the version, which has an x.y.z
format. These represent the major version, minor version, and update
version respectively. Knowing the running TDX Module version is valuable
for bug reporting and debugging. Note that the module does expose other
pieces of version-related metadata, such as build number and date. Those
aren't retrieved for now, that can be added if needed in the future.

Retrieve the TDX Module version using the existing metadata reading
interface. Later changes will expose this information. The metadata
reading interfaces have existed for quite some time, so this will work
with older versions of the TDX module as well - i.e. this isn't a new
interface.

As a side note, the global metadata reading code was originally set up
to be auto-generated from a JSON definition [1]. However, later [2] this
was found to be unsustainable, and the autogeneration approach was
dropped in favor of just manually adding fields as needed (e.g. as in
this patch).

Signed-off-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kiryl Shutsemau <kas@kernel.org>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Link: https://lore.kernel.org/kvm/CABgObfYXUxqQV_FoxKjC8U3t5DnyM45nz5DpTxYZv2=
x_uFK_Kw@mail.gmail.com/ # [1]
Link: https://lore.kernel.org/all/1e7bcbad-eb26-44b7-97ca-88ab53467212@intel.=
com/ # [2]
Link: https://patch.msgid.link/20260109-tdx_print_module_version-v2-1-e10e4ca=
5b450@intel.com
---
 arch/x86/include/asm/tdx_global_metadata.h  |  7 +++++++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 16 ++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/x86/include/asm/tdx_global_metadata.h b/arch/x86/include/as=
m/tdx_global_metadata.h
index 060a2ad..40689c8 100644
--- a/arch/x86/include/asm/tdx_global_metadata.h
+++ b/arch/x86/include/asm/tdx_global_metadata.h
@@ -5,6 +5,12 @@
=20
 #include <linux/types.h>
=20
+struct tdx_sys_info_version {
+	u16 minor_version;
+	u16 major_version;
+	u16 update_version;
+};
+
 struct tdx_sys_info_features {
 	u64 tdx_features0;
 };
@@ -35,6 +41,7 @@ struct tdx_sys_info_td_conf {
 };
=20
 struct tdx_sys_info {
+	struct tdx_sys_info_version version;
 	struct tdx_sys_info_features features;
 	struct tdx_sys_info_tdmr tdmr;
 	struct tdx_sys_info_td_ctrl td_ctrl;
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/=
tdx/tdx_global_metadata.c
index 13ad266..0454124 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -7,6 +7,21 @@
  * Include this file to other C file instead.
  */
=20
+static int get_tdx_sys_info_version(struct tdx_sys_info_version *sysinfo_ver=
sion)
+{
+	int ret =3D 0;
+	u64 val;
+
+	if (!ret && !(ret =3D read_sys_metadata_field(0x0800000100000003, &val)))
+		sysinfo_version->minor_version =3D val;
+	if (!ret && !(ret =3D read_sys_metadata_field(0x0800000100000004, &val)))
+		sysinfo_version->major_version =3D val;
+	if (!ret && !(ret =3D read_sys_metadata_field(0x0800000100000005, &val)))
+		sysinfo_version->update_version =3D val;
+
+	return ret;
+}
+
 static int get_tdx_sys_info_features(struct tdx_sys_info_features *sysinfo_f=
eatures)
 {
 	int ret =3D 0;
@@ -89,6 +104,7 @@ static int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 {
 	int ret =3D 0;
=20
+	ret =3D ret ?: get_tdx_sys_info_version(&sysinfo->version);
 	ret =3D ret ?: get_tdx_sys_info_features(&sysinfo->features);
 	ret =3D ret ?: get_tdx_sys_info_tdmr(&sysinfo->tdmr);
 	ret =3D ret ?: get_tdx_sys_info_td_ctrl(&sysinfo->td_ctrl);

