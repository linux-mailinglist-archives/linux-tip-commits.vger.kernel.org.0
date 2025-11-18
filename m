Return-Path: <linux-tip-commits+bounces-7387-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 286C3C6A05D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 15:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 475454E822A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 14:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB6C30F93D;
	Tue, 18 Nov 2025 14:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h3V3lt55";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CzB2VGW1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC4B317711;
	Tue, 18 Nov 2025 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476121; cv=none; b=pHunfcQj8kmSHMXb74dWpyTF0DRWo0+f3L0xX0Fqg7XRe6U3moEO9nzq/xnMpeSEe/tLYok0yrTOkx2K+IllF+TjxJplkMpeCgIAsWHlX5uAdZCAbjPtMznJMXXhuS393QBUqxXYbtcVtHQhmd+eC6JdyY3blZrxWeRR9MS7ezM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476121; c=relaxed/simple;
	bh=4Tla6CCEioxyMl8YfvTIw3DdQ7qHWwrX1DiwfimzZ9s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=opqEjs+chk77XjXx9O8xLKNEhVJgeIgjHHY5eU60h20sU3/riCwDtn7Mpq8Pi6k2tCl9ujZM+CG8R7Mteys+/JEd7ApmL+q3w0OLGW8vLI5hhDHDDphcwjjT9DBprrhuqwhbYwu5QApejoD5ATPdchbr6B5IpCPor8LE+lPKdAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h3V3lt55; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CzB2VGW1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Nov 2025 14:28:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763476117;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4d/fyHx5+TMrKYMq2TXVvIvOIWxC7QzCemxUEmjAPQY=;
	b=h3V3lt55E/79qhb2SurPVE/eie5UO52kIW+ieKv7jzxhvfpYC3KqHC8LsYKN5/Q2b7E42k
	5JzIGR9pA3/3m+0I+CC8phMFCuHX7gff2WFv03oi3pWCy/iQBxYJIgMMSGeHSgl+3yGc22
	nsMVXWGMPtXjUuEUkTMsFeudUfNLg2+htCysFFneSX9ZxRtuDsUJ70qHd/SnsAU4VfPxj2
	Y7t8z6h6xFBJh1NOz8Ne/6p9pSU2A/bxBdFH0sx3Nsek46+50jDxqNZj/eqFE7Seu6uewK
	boM0acTz0iQFlzBZ+BivpHeYWIYjNSP8QZ9V8qZZ+TBhhiFUz8rnbR32yfUmwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763476117;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4d/fyHx5+TMrKYMq2TXVvIvOIWxC7QzCemxUEmjAPQY=;
	b=CzB2VGW1trLjzYViRRRtoieGzrQygPhH4kR1O0OKHSBrdZQ7wgjohY5MZN/2DM8MkAJ8KX
	r/zrRvHS3v3kfuDg==
From: "tip-bot2 for Christophe Leroy" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/uaccess] lib/strn*,uaccess: Use
 masked_user_{read/write}_access_begin when required
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ccb5e4b0fa49ea9c740570949d5e3544423389757=2E1763396?=
 =?utf-8?q?724=2Egit=2Echristophe=2Eleroy=40csgroup=2Eeu=3E?=
References: =?utf-8?q?=3Ccb5e4b0fa49ea9c740570949d5e3544423389757=2E17633967?=
 =?utf-8?q?24=2Egit=2Echristophe=2Eleroy=40csgroup=2Eeu=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176347611584.498.1344690421091616025.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/uaccess branch of tip:

Commit-ID:     4322c8f81c58da493a3c46eda32f0e7534a350a0
Gitweb:        https://git.kernel.org/tip/4322c8f81c58da493a3c46eda32f0e7534a=
350a0
Author:        Christophe Leroy <christophe.leroy@csgroup.eu>
AuthorDate:    Mon, 17 Nov 2025 17:43:44 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Nov 2025 15:27:35 +01:00

lib/strn*,uaccess: Use masked_user_{read/write}_access_begin when required

Properly use masked_user_read_access_begin() and
masked_user_write_access_begin() instead of masked_user_access_begin() in
order to match user_read_access_end() and user_write_access_end().  This is
important for architectures like PowerPC that enable separately user reads
and user writes.

That means masked_user_read_access_begin() is used when user memory is
exclusively read during the window and masked_user_write_access_begin()
is used when user memory is exclusively writen during the window.
masked_user_access_begin() remains and is used when both reads and
writes are performed during the open window. Each of them is expected
to be terminated by the matching user_read_access_end(),
user_write_access_end() and user_access_end().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/cb5e4b0fa49ea9c740570949d5e3544423389757.17633=
96724.git.christophe.leroy@csgroup.eu
---
 lib/strncpy_from_user.c | 2 +-
 lib/strnlen_user.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index 6dc2349..5bb752f 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -126,7 +126,7 @@ long strncpy_from_user(char *dst, const char __user *src,=
 long count)
 	if (can_do_masked_user_access()) {
 		long retval;
=20
-		src =3D masked_user_access_begin(src);
+		src =3D masked_user_read_access_begin(src);
 		retval =3D do_strncpy_from_user(dst, src, count, count);
 		user_read_access_end();
 		return retval;
diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
index 6e489f9..4a6574b 100644
--- a/lib/strnlen_user.c
+++ b/lib/strnlen_user.c
@@ -99,7 +99,7 @@ long strnlen_user(const char __user *str, long count)
 	if (can_do_masked_user_access()) {
 		long retval;
=20
-		str =3D masked_user_access_begin(str);
+		str =3D masked_user_read_access_begin(str);
 		retval =3D do_strnlen_user(str, count, count);
 		user_read_access_end();
 		return retval;

