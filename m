Return-Path: <linux-tip-commits+bounces-6635-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF7FB5785D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 13:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE6DA7AA54D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 11:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272513093AD;
	Mon, 15 Sep 2025 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LCwwJowU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eHzF2oX8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DD53090C6;
	Mon, 15 Sep 2025 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935682; cv=none; b=vBz3lMqfOioUOiw6Iteq3hij9lMW0ppWu74snHDys9F1LbEUqLQbn+DEvNiUsGNLgxPFnnY4tU9FX48xBuC1iAAD5/TPH5pnNcV58BLoS+T5pJsYpZUE//XlejLaxYIOv60EXH8rvzWN/ilw08QvphZMoA4D2ukJTE5/tmwfI/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935682; c=relaxed/simple;
	bh=BKICxK6iSZQAD50Deux/ALrfLydfZiRfZcSRZK6xuyE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Glzl+sJ12bJMG+6JULs2b1V2WVHuFhOnhF2cJh/uf6essoPzluoMuEG3Hq1UAxRn3i77XZdq+7+XSNKnKQnSZWBfCOnNi0Y2S08miTDI3/S/fyxmwLH5eh4jlrKvyOaG0B6wf8hFvkOH9OoK3zPndqvxmyVRUZ/eFanvwHYylTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LCwwJowU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eHzF2oX8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 11:27:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757935678;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=zzF/NgE3bHSNOtk39ogLdXRYxVq0XlRzzMEA53+BPCM=;
	b=LCwwJowUsddnMdnP3e0bXYUaYkXsIvaw+mHbokkeZU/qKlO5ZO/hRrSuEXiGXGKdqnuoYr
	FmdKsgIaG4tqAbtfk2gPqb4smPvQVMsAuouH3BzAtM0RScsi7acjD30mMJxpWMe6Farmit
	qQBFY1YXfU11jESvBCfFQ5CFtcwGIreF4fLvj+oceS0sITbN75PPw/3bDm/KbhsXu1ItV8
	cVPMcYfjM5fV5SgBS+0I3S5rM+RwnDLR8uy1usXp3rA4cEILuzdt0HSToeE1LbHABr0DEV
	tuaQm+lMWFCzIT0YZr+pEzNhvbyUpb3inQDsdfCYArdNU1QWId0/+MIC7SJNDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757935678;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=zzF/NgE3bHSNOtk39ogLdXRYxVq0XlRzzMEA53+BPCM=;
	b=eHzF2oX8ztfPbP5h9vHXmjGTg8qHd3cZP4aLm7lVYJh0hbhSJoySHAZeeWfSYW6+8IsU53
	IW9RlRhtNg3H/PBA==
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
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175793567707.709179.3797022840301715360.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     0e58f6a7dd689c73d67e6a2164b46d4618f2698a
Gitweb:        https://git.kernel.org/tip/0e58f6a7dd689c73d67e6a2164b46d4618f=
2698a
Author:        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
AuthorDate:    Mon, 23 Jun 2025 16:50:50 +09:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 11:44:01 +02:00

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

