Return-Path: <linux-tip-commits+bounces-7348-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADE5C5D728
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 14:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 717B2363C2B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 13:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C298731AF06;
	Fri, 14 Nov 2025 13:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FZa3qrjt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JsDKDFC/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3843F31A578;
	Fri, 14 Nov 2025 13:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763127895; cv=none; b=HwX6Rlb7xa3dorpt3p/pmISBtpstUeQQUDh1IIWSIGnY+x8naxNzW+7VGwwYPNayRn90PyWSyJ3TTY8/bVOJdMl81LwyhEsxGhLWFl+l+a6Rk11akW3rKQxefkJLEHXrN1YwcrIADK9Olaq2dYZwtxTCRkJsinLaNHBtas0EnTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763127895; c=relaxed/simple;
	bh=dW+BLs0JW6xm/CpeZC4XE2YxgF2OQN1V9YU2iqyHn6E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NoQ8ZPK94bntS9+kmAFfhpyV31frnTmiaWK9exI+RiPpamYFTuI22aLGBuBXcBIs5uHxKHEqNEJWPk4CiHGSa3y9vD5AGXHQMIQSGvHsnON22A1ZphROkiavyD0+6WcjTU5mzIie2XYME6Hzd5MwU80QnejD48dmevySy1OJzNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FZa3qrjt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JsDKDFC/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Nov 2025 13:44:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763127892;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yycprBbh6wcLgq1un0gcRZtVaynxIm7GSp2c3rx7c+Y=;
	b=FZa3qrjtnE9MzHY+9t3k6vSVQLqNfh5pR4knO34ksL/GEFqZr+zV79w72/2zTdThy67dMK
	eewF1gOv/RTi22pbdpe6okEiECesBV4jzi3dDitlurLCaaZfdRe/usO7HHEHBcW3fV5Exi
	QYLeLf6PZn9+58l1n09PseSdzZuW3ejLI+5KMvvUfNKHgupsTxc9KvalmAb+bGdUbN4l9h
	36dYKQ/4prSF/iJWzKotQI9MJPS1wE3p3dWtqespqmIJLAYXi+S/7gJOuSJSThpvijfY9m
	6f7YRUwydpbK5rRJ2Ub0pGeQQ7VPK35qf0daPkngcxTyfibMxMaqbekPhfCgFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763127892;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yycprBbh6wcLgq1un0gcRZtVaynxIm7GSp2c3rx7c+Y=;
	b=JsDKDFC/azq8lSaLYL34FTpfadiCXH6jVIaI+yQVvSC/1GcC10Yo2oju+rIaLCkLmWHlf0
	BDQAQWLYpGIH/nAw==
From: "tip-bot2 for Carlos Llamas" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/futex] selftests/futex: Add newline to ksft_exit_fail_msg()
Cc: Carlos Llamas <cmllamas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251015173556.2899646-1-cmllamas@google.com>
References: <20251015173556.2899646-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176312789184.498.9799101319126383995.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     9407d138b8d5eff1cabceb4b3176f03191871479
Gitweb:        https://git.kernel.org/tip/9407d138b8d5eff1cabceb4b3176f031918=
71479
Author:        Carlos Llamas <cmllamas@google.com>
AuthorDate:    Wed, 15 Oct 2025 17:35:41=20
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 14 Nov 2025 14:39:36 +01:00

selftests/futex: Add newline to ksft_exit_fail_msg()

This was missed in commit e5c04d0f3ea0 ("selftests/futex: Refactor
futex_wait with kselftest_harness.h") while replacing previous perror()
calls, which automatically append the newline character.

Fixes: e5c04d0f3ea0 ("selftests/futex: Refactor futex_wait with kselftest_har=
ness.h")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251015173556.2899646-1-cmllamas@google.com
---
 tools/testing/selftests/futex/functional/futex_wait.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait.c b/tools/te=
sting/selftests/futex/functional/futex_wait.c
index 152ca46..4cd87f2 100644
--- a/tools/testing/selftests/futex/functional/futex_wait.c
+++ b/tools/testing/selftests/futex/functional/futex_wait.c
@@ -108,14 +108,14 @@ TEST(file_backed)
 	/* Testing a file backed shared memory */
 	fd =3D open(SHM_PATH, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
 	if (fd < 0)
-		ksft_exit_fail_msg("open");
+		ksft_exit_fail_msg("open\n");
=20
 	if (ftruncate(fd, sizeof(f_private)))
-		ksft_exit_fail_msg("ftruncate");
+		ksft_exit_fail_msg("ftruncate\n");
=20
 	shm =3D mmap(NULL, sizeof(f_private), PROT_READ | PROT_WRITE, MAP_SHARED, f=
d, 0);
 	if (shm =3D=3D MAP_FAILED)
-		ksft_exit_fail_msg("mmap");
+		ksft_exit_fail_msg("mmap\n");
=20
 	memcpy(shm, &f_private, sizeof(f_private));
=20

