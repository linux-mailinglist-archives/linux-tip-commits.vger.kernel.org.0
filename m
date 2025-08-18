Return-Path: <linux-tip-commits+bounces-6262-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC55B29E63
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 11:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2602F3ADC46
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 09:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5392930FF22;
	Mon, 18 Aug 2025 09:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="chc08UXd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F8xEk4UF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF0330FF20;
	Mon, 18 Aug 2025 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510649; cv=none; b=htF0Bdhd9rKmpkYHQ0KojRDmN9QtpaVBfHP9nE5mleJShW1S6BA4s2AsBePeEKCzKx7q7kagiFGGa6p+QOtBv8weMNIfg9hYk/uc08JaVL2lOwCMKROZqRttDbTXyCWIrimhrdoqRfcmdaAOCt3wyy2PLYFtVv5Fvt4vqMDaVE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510649; c=relaxed/simple;
	bh=M+fgFzdG43ADz6Qwy5keVjH1bL2S0QOm7hfn+mE436Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qEl3vdsshkavDu7EIblEcRZppLL9gpF1OlzrUx2+E75dK96Um4mXER3RwdHOVQfQ1vaOSGIHkHDtx7iWUymVAn2nvTSp3+5QUd0+MmdcI1UWW5vhhSEIQa0s5xv5QrYtk3iU/x86GgwGhx+W9/o14QffKkOAqnlgVP/aTZvc+2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=chc08UXd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F8xEk4UF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Aug 2025 09:50:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755510644;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l0sD1ix5EKixvEE7HleelC7ipd+6d7TQJTczElI6cgs=;
	b=chc08UXd3qzC++wmn4yWcMhnQtryHX7SoG9LXhWoEyOM4XgVC3MIXkPj+0U9nDvTLB5Jr9
	P9MGZlhpoNwSJXs/Pbs1yp9h8GzwP40R3p5h4NIejaESoLeGx1fNldw+6SDInm1R+cHcOc
	PGMtzF403YwXCNX/6iOSp75lSiBti/KGXB5Ky6OZ7NCNc12SGQjggRXkTLirmrYVYnniEA
	ltB2z+bsP+QJbDhZImMYkmPAw/rgkqcpEDWjVzkICVTKayz7nIAKq9llJsP19tldS6e5s3
	81zSclL9eIAx5G/rnNexoP3shEFht3h34jmrKs6hOr0DCaZW7dCIdKWwj3HTVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755510644;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l0sD1ix5EKixvEE7HleelC7ipd+6d7TQJTczElI6cgs=;
	b=F8xEk4UFiyuPqqYi4xkSRaHq6qIaVSiRgAeEDE3V9IE+Quw5jU81RYjzLuCu/AN1WGGW9j
	zuode4KkkajD6pDQ==
From: "tip-bot2 for Shaopeng Tan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] fs/resctrl: Optimize code in rdt_get_tree()
Cc: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>,
 James Morse <james.morse@arm.com>, Koba Ko <kobak@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250623075051.3610592-1-tan.shaopeng@jp.fujitsu.com>
References: <20250623075051.3610592-1-tan.shaopeng@jp.fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175551064043.1420.7493176605077418163.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     b470929e21393f37cae51a922ef319a753273719
Gitweb:        https://git.kernel.org/tip/b470929e21393f37cae51a922ef319a7532=
73719
Author:        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
AuthorDate:    Mon, 23 Jun 2025 16:50:50 +09:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 18 Aug 2025 11:34:29 +02:00

fs/resctrl: Optimize code in rdt_get_tree()

schemata_list_destroy() has to be called if schemata_list_create() fails.

rdt_get_tree() calls schemata_list_destroy() in two different ways:
directly if schemata_list_create() itself fails and
on the exit path via the out_schemata_free goto label.

Remove schemata_list_destroy() call on schemata_list_create() failure.
Use existing out_schemata_free goto label instead.

Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: James Morse <james.morse@arm.com>
Reviewed-by: Koba Ko <kobak@nvidia.com>
Link: https://lore.kernel.org/20250623075051.3610592-1-tan.shaopeng@jp.fujits=
u.com
---
 fs/resctrl/rdtgroup.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 77d0822..5f0b7cf 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -2608,10 +2608,8 @@ static int rdt_get_tree(struct fs_context *fc)
 		goto out_root;
=20
 	ret =3D schemata_list_create();
-	if (ret) {
-		schemata_list_destroy();
-		goto out_ctx;
-	}
+	if (ret)
+		goto out_schemata_free;
=20
 	ret =3D closid_init();
 	if (ret)
@@ -2683,7 +2681,6 @@ out_closid_exit:
 	closid_exit();
 out_schemata_free:
 	schemata_list_destroy();
-out_ctx:
 	rdt_disable_ctx();
 out_root:
 	rdtgroup_destroy_root();

