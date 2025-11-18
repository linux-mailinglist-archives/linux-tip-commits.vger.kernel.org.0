Return-Path: <linux-tip-commits+bounces-7388-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E64EC69F4E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 15:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 28C282BD49
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 14:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEBC35A137;
	Tue, 18 Nov 2025 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uktk+scR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1mNaGDcs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404BC34D906;
	Tue, 18 Nov 2025 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476122; cv=none; b=Z228MEfgQOpzY0VDI7g9C2gBBGAzbCjHWIikJU66m+FMnQEsKQ2f40kYNV8tZD8jbGwDvTDMXizrkyu3REH6TcHppx030TD9CRCbfSWMHpiyk7PTOkjdpw4j9CObZlDLACWWCH6PsKPWNVtKy/qBzAAKQma88Z1WZ9NsZNyiO90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476122; c=relaxed/simple;
	bh=bkJmvl0sPvPILdAnJCfalxAPdRUseDX4gd/kBEcRmNY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=g/OIxyoAFNxzaW7eMKT6Y9voIgLY2XxRD1DsfZme7r1ahCZI+OjAfYprqucrVw+a3yofyv/IxPPk3tYQCD4rYU49zt95cfoBj3souVVc3KTAYohOj6DE61H5ZXf/yR9kUR292FcG4IhlgzYJXPd/B7pUyZc38WwQ9e1B1UqfmKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Uktk+scR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1mNaGDcs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Nov 2025 14:28:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763476118;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L0Py9X/KPYsacvInFr23R/fx7koSojO8N3QY53XkN6A=;
	b=Uktk+scRf+coy02DZTiIKWg5kg/P29/rl68wZ+RgdenJDRI+r4XOAKL8hS/rwUARuo4o6m
	8ySvw5VjYQNo8Fq9WFaHKQFih7aDMlcyeQzkeaSz8N88apTqf0ODv7bjgNJ2VBnmaitXkE
	CqFPInnkWbiUhE6WsAL9ZkIMf02od4KC9ZOPoK9tTzs4vYvDcpZs6pvON+YM44SLOE3ek6
	vLsaBoJz5ayF37eduCJNQxp6qyQSvFsBlYkkvCI2w1lepLue10Qy+CTd3+NzJu4uGnnNCO
	B+j2Ut7LO/mVreLuN7jSAv0h0QJxjlFjhHUAfr4oBsVyKOMYqsNAlX3vr6R6EQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763476118;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L0Py9X/KPYsacvInFr23R/fx7koSojO8N3QY53XkN6A=;
	b=1mNaGDcsTcsppoX1HKaLVL9rIjukRCUn9loTLCb69Hdow3G42SXieCBukE5q4rbSb+dUR7
	3XPZ5ukOvxFvACDg==
From: "tip-bot2 for Christophe Leroy" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/uaccess] scm: Convert put_cmsg() to scoped user access
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C793219313f641eda09a892d06768d2837246bf9f=2E1763396?=
 =?utf-8?q?724=2Egit=2Echristophe=2Eleroy=40csgroup=2Eeu=3E?=
References: =?utf-8?q?=3C793219313f641eda09a892d06768d2837246bf9f=2E17633967?=
 =?utf-8?q?24=2Egit=2Echristophe=2Eleroy=40csgroup=2Eeu=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176347611705.498.9194390520921635565.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/uaccess branch of tip:

Commit-ID:     1c204914bc4401623a1b242305c583060a0b7e4f
Gitweb:        https://git.kernel.org/tip/1c204914bc4401623a1b242305c583060a0=
b7e4f
Author:        Christophe Leroy <christophe.leroy@csgroup.eu>
AuthorDate:    Mon, 17 Nov 2025 17:43:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Nov 2025 15:27:34 +01:00

scm: Convert put_cmsg() to scoped user access

Replace the open coded implementation with the scoped user access guard.

That also corrects the imbalance between masked_user_access_begin() and
user_write_access_end(), which would affect PowerPC when it gains masked
user access support.

No functional change intended.

[ tglx: Amend change log ]

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/793219313f641eda09a892d06768d2837246bf9f.17633=
96724.git.christophe.leroy@csgroup.eu
---
 net/core/scm.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/net/core/scm.c b/net/core/scm.c
index 66eaee7..cd87f66 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -273,17 +273,13 @@ int put_cmsg(struct msghdr * msg, int level, int type, =
int len, void *data)
=20
 		check_object_size(data, cmlen - sizeof(*cm), true);
=20
-		if (can_do_masked_user_access())
-			cm =3D masked_user_access_begin(cm);
-		else if (!user_write_access_begin(cm, cmlen))
-			goto efault;
-
-		unsafe_put_user(cmlen, &cm->cmsg_len, efault_end);
-		unsafe_put_user(level, &cm->cmsg_level, efault_end);
-		unsafe_put_user(type, &cm->cmsg_type, efault_end);
-		unsafe_copy_to_user(CMSG_USER_DATA(cm), data,
-				    cmlen - sizeof(*cm), efault_end);
-		user_write_access_end();
+		scoped_user_write_access_size(cm, cmlen, efault) {
+			unsafe_put_user(cmlen, &cm->cmsg_len, efault);
+			unsafe_put_user(level, &cm->cmsg_level, efault);
+			unsafe_put_user(type, &cm->cmsg_type, efault);
+			unsafe_copy_to_user(CMSG_USER_DATA(cm), data,
+					    cmlen - sizeof(*cm), efault);
+		}
 	} else {
 		struct cmsghdr *cm =3D msg->msg_control;
=20
@@ -301,8 +297,6 @@ int put_cmsg(struct msghdr * msg, int level, int type, in=
t len, void *data)
 	msg->msg_controllen -=3D cmlen;
 	return 0;
=20
-efault_end:
-	user_write_access_end();
 efault:
 	return -EFAULT;
 }

