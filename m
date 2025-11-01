Return-Path: <linux-tip-commits+bounces-7126-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DC6C28695
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94A233A59E3
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDDD28D84F;
	Sat,  1 Nov 2025 19:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bsoBW4bj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Migag9KY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2C91D9A54;
	Sat,  1 Nov 2025 19:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026087; cv=none; b=Bo7sJueFjXTitHSBpXVAP+KmD5P0gzbqXgOena4ddeu51qYvBV2p3hxXLrSiyNQB1vx7nkQycrgyXVcJr/3W0ZxBUbYSMnXti+HB6DqKtjceS3pgCFITmLYSJryzyXHwCOwa1LQ6q4CfAMM6pdLplfj77Yzr/mTWLV0BIGwz4hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026087; c=relaxed/simple;
	bh=/03zCaTk2E1BMf5CcsfVDO+rPMlMTBDeTSFYzY33xmY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gx+aBjeJks7K7VAP+2bGFAS/chd7mdyJHShIqu0RO1ERHiT47MFGeBEsqw3+LYnvB6OOdmxOq83WVctiz3O/ZS4lu+gPukUmk5e4ojI7uSccWTrwYKbp4IDGJzMKXsfeQiye0PcF2wRqEUTYsTRqBbAiVt3e4IbP0fhWZ9p/Awc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bsoBW4bj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Migag9KY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:41:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026084;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AUiVCGCC9/7OpT6fo8YIJZVID34A/SLj5B/KqjvbCic=;
	b=bsoBW4bjNIgkOKKh4NDxD5OR1xG/E2IQ23KgMjhRc8akYr8f8KLGgY5N6HN1Dwkqd7vLMn
	YmXF/MuNScFZVwFvUr4PXFo0JEMQMMooinw/ClgvzRKT/qOZjW+fjqvo7ruH8dDULq4Q8K
	BM763vD/3ImDyaNQVB0vPAZEmmjXDo4KJA0BWhN6XQaNWRecDIXM6iqLIDaskQz4v8X0/m
	XGtEnlY8aBUWbCfpDXZm7/b3Sv729XcNj26DkgQ4jDirzMGHNIo9lFj7MP4jA9vgFNy1qg
	+qWhMNC9dGxV6mBH12i5UtCay+z03SBilWJe1epJ8sxvjgiWCUC0iii6AruUEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026084;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AUiVCGCC9/7OpT6fo8YIJZVID34A/SLj5B/KqjvbCic=;
	b=Migag9KYe8OXhQO5M/rsYRLBCeb1wj2UDRQYOBhInArvw+Uz1OemJVZhFMLwStpEPLzqAV
	WZufHp8SMhWzamCA==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers/migration: Remove unused "cpu" parameter
 from tmigr_get_group()
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251024132536.39841-6-frederic@kernel.org>
References: <20251024132536.39841-6-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202608274.2601451.17999971643884463836.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     93643b90d6c141cb90dca7c24eabee800f51f908
Gitweb:        https://git.kernel.org/tip/93643b90d6c141cb90dca7c24eabee800f5=
1f908
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 24 Oct 2025 15:25:35 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:38:25 +01:00

timers/migration: Remove unused "cpu" parameter from tmigr_get_group()

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251024132536.39841-6-frederic@kernel.org
---
 kernel/time/timer_migration.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index bddd816..73d9b06 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1511,8 +1511,7 @@ static void tmigr_init_group(struct tmigr_group *group,=
 unsigned int lvl,
 	group->groupevt.ignore =3D true;
 }
=20
-static struct tmigr_group *tmigr_get_group(unsigned int cpu, int node,
-					   unsigned int lvl)
+static struct tmigr_group *tmigr_get_group(int node, unsigned int lvl)
 {
 	struct tmigr_group *tmp, *group =3D NULL;
=20
@@ -1636,7 +1635,7 @@ static int tmigr_setup_groups(unsigned int cpu, unsigne=
d int node,
 		root_mismatch =3D tmigr_root->numa_node !=3D node;
=20
 	for (i =3D start_lvl; i < tmigr_hierarchy_levels; i++) {
-		group =3D tmigr_get_group(cpu, node, i);
+		group =3D tmigr_get_group(node, i);
 		if (IS_ERR(group)) {
 			err =3D PTR_ERR(group);
 			i--;

