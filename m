Return-Path: <linux-tip-commits+bounces-6155-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F253B0D5FB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Jul 2025 11:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11E93A6C72
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Jul 2025 09:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AB62DCBE2;
	Tue, 22 Jul 2025 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WdQtm57j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S9rb3WN5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90652DCBEC;
	Tue, 22 Jul 2025 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753176570; cv=none; b=C+8eNXO9dVbPAq6Tep9hFrZfHrsSyfKQbNAek0PQ7YdxSBP5DDPOwnbdHD3qVW7yjEWNLJsUZDlR5CQWCUxLqsQeXRoxncg9pBoI9eHOdxIwzUqVdp4iNGxbnQtMte/8JPOSg8NeVSroHiUBx6bC3X9IBxTWgGbAfHy8o2dn514=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753176570; c=relaxed/simple;
	bh=dpvoSwf+sTIPvv23actFJfg1YhNNuo4V8BfYc+jojnY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=p7j7a2r8qqTl9KtyQQue+mS1pyasLws8z7dTti+xzIiClGFJcPy/RZnFk/+wFRc9FBk4+7fDppHFAtVKDgAnA5kzFp8MIcO6g82lpPnE97ANX9bfqLKuFNC5OcVXErBy+bYdwyULJGP9QmeG5o8UZH5Fvp5FALGeDLFCSud5tKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WdQtm57j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S9rb3WN5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 22 Jul 2025 09:29:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753176566;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qh/PDDSJ/kPRKma5VsJ5bV8KcMM+faYORFyeh6rjU0Y=;
	b=WdQtm57jXWfn+Z6o6yzMvOhKQhLXh6bZvbvWvExCQ9VXnreuyQnxI4ubbK2UjrZcTwKJsz
	ml3NRSY+vOTiTGFnZqNkDCrUWoaIVVM/C9TjW/Wp+izpIwt0YnoNQNKgALnZQyqzlghFnX
	dtGrv2+/drHZ8qRCDxzyYKUs39mQziwBUHDzFs9+Kw9F2nF837LPv0n2VOXj15mBQeMswe
	iy5cLV0czeIIj7rG1DzmzyJS2TgumssekLX450T4AJBkMWIlR5NyUp5dNaySD1iU+AVDaf
	OTwQirU20Sbd0NyFgGS2E1un/E1Naq3TAfxPSpxqrBW8kYFWG5agk0k4d8RufQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753176566;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qh/PDDSJ/kPRKma5VsJ5bV8KcMM+faYORFyeh6rjU0Y=;
	b=S9rb3WN5pa2Nya0x546zb07BfWfec6q+H3CZKS5l+HCmsknP1dYQ8WLzg/Tfvc/49/HjCF
	I5UUAQol7nmFGwAw==
From: "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] selftests/futex: Fix spelling mistake
 "Succeffuly" -> "Successfully"
Cc: Colin Ian King <colin.i.king@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250715130627.1907017-1-colin.i.king@gmail.com>
References: <20250715130627.1907017-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175317656537.1420.8667684723514409693.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     e40892214b454c8734350d82374f46c2e495a4d2
Gitweb:        https://git.kernel.org/tip/e40892214b454c8734350d82374f46c2e49=
5a4d2
Author:        Colin Ian King <colin.i.king@gmail.com>
AuthorDate:    Tue, 15 Jul 2025 14:06:26 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 22 Jul 2025 11:18:43 +02:00

selftests/futex: Fix spelling mistake "Succeffuly" -> "Successfully"

There is a spelling mistake in a ksft_exit_fail_msg() message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250715130627.1907017-1-colin.i.king@gmail=
.com

---
 tools/testing/selftests/futex/functional/futex_priv_hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/futex_priv_hash.c b/too=
ls/testing/selftests/futex/functional/futex_priv_hash.c
index a9cedc3..aea001a 100644
--- a/tools/testing/selftests/futex/functional/futex_priv_hash.c
+++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
@@ -122,7 +122,7 @@ static void futex_dummy_op(void)
 	}
 	ret =3D pthread_mutex_timedlock(&lock, &timeout);
 	if (ret =3D=3D 0)
-		ksft_exit_fail_msg("Succeffuly locked an already locked mutex.\n");
+		ksft_exit_fail_msg("Successfully locked an already locked mutex.\n");
=20
 	if (ret !=3D ETIMEDOUT)
 		ksft_exit_fail_msg("pthread_mutex_timedlock() did not timeout: %d.\n", ret=
);

