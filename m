Return-Path: <linux-tip-commits+bounces-6972-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E310BF5CB4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Oct 2025 12:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 195973B04DB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Oct 2025 10:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC25432C936;
	Tue, 21 Oct 2025 10:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yQY7gvIm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dg+paZ0F"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0013C32A3FF;
	Tue, 21 Oct 2025 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761042929; cv=none; b=gnYAIQ0RdbCZAEXVbovDHh1WrBXgxn3sPEutQsVeZ0S6g5ODCrriJUIQ7yPSRS1LdVb6zoD73oe1IKqc2AcSNyHditg6N9234thOER3qwowPMzTGcwERDAuB3bAfGGG92tC+xyhDQxZeCdcgbgeI+boMdpISzUuAOminkHHI2a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761042929; c=relaxed/simple;
	bh=klr0JF1YW37+j5d+Zd0R9KkWWO/XWiUx4auA82yIp5c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FvMjEnoo1bQIH1b+Ucxi4nZ4iBo1VtVxLRHFPri4JRa5ZmwFEPIbITHf6HWin2oJTRYt6X6xFlyDuEIBgKc/rjG1GSUopUTaZ5ywPOBL2ujXji8W4kp1Z0iO+nAEPYuaHk9f4bX10e1YfsFh4JFIpCacSi2Dl5NoapylmoYshZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yQY7gvIm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dg+paZ0F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 21 Oct 2025 10:35:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761042926;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7+3qoHqBcGGGynjN2PodwFxJF+gfSlHEQkSBriJwbSU=;
	b=yQY7gvIm8eLDVEni+rTimtz1SR/mUdjCpWyDdpyPhuHSqwS28vjbHabDKmDFWqUzIrpK8n
	lmkiHHeXcrepnhhur+UDvvgmIT86YzQUBZDLlORClupiy+kwWetjtCCiyYmuGp4Vy/+4+9
	yIfZNJllY9vAiziwcULI7sdfjWLq7FdFR1rmfWPD0ggth2JVNBbggI8dMZ7OTfLrmFLXeh
	OOaX+8UC7yaEdFf50aKHIEDa2dr+3BPUjTNBXrN0X2Y2uUtMj6IeKZ3gVM/+T/ca3Xyi1g
	DchUqYpwCNLCxaLEprMTmIYIEiAUQgm2WGeDA1SvSDVqa9MZeTI16eVxaWFi/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761042926;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7+3qoHqBcGGGynjN2PodwFxJF+gfSlHEQkSBriJwbSU=;
	b=dg+paZ0FmBRcT/wgZONioxqPi/avuoNL+bzKKgzoSUdLe+Vp/6IjM4ybLVH/7t+bLPwneC
	rnsRuuTKhQpjowAg==
From: "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] documentation: seqlock: fix the wrong
 documentation of read_seqbegin_or_lock/need_seqretry
Cc: Oleg Nesterov <oleg@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250928162029.GA3121@redhat.com>
References: <20250928162029.GA3121@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176104292495.2601451.15194014939190830588.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     28a0ee311960baad97bf85e1e995aed4a71e22a2
Gitweb:        https://git.kernel.org/tip/28a0ee311960baad97bf85e1e995aed4a71=
e22a2
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Sun, 28 Sep 2025 18:20:29 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 21 Oct 2025 12:31:56 +02:00

documentation: seqlock: fix the wrong documentation of read_seqbegin_or_lock/=
need_seqretry

The comments and pseudo code in Documentation/locking/seqlock.rst are wrong:

	int seq =3D 0;
	do {
		read_seqbegin_or_lock(&foo_seqlock, &seq);

		/* ... [[read-side critical section]] ... */

	} while (need_seqretry(&foo_seqlock, seq));

read_seqbegin_or_lock() always returns with an even "seq" and need_seqretry()
doesn't change this counter. This means that seq is always even and thus the
locking pass is simply impossible.

IOW, "_or_lock" has no effect and this code doesn't differ from

	do {
		seq =3D read_seqbegin(&foo_seqlock);

		/* ... [[read-side critical section]] ... */

	} while (read_seqretry(&foo_seqlock, seq));

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 Documentation/locking/seqlock.rst |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/locking/seqlock.rst b/Documentation/locking/seqloc=
k.rst
index 3fb7ea3..9899871 100644
--- a/Documentation/locking/seqlock.rst
+++ b/Documentation/locking/seqlock.rst
@@ -220,13 +220,14 @@ Read path, three categories:
    according to a passed marker. This is used to avoid lockless readers
    starvation (too much retry loops) in case of a sharp spike in write
    activity. First, a lockless read is tried (even marker passed). If
-   that trial fails (odd sequence counter is returned, which is used as
-   the next iteration marker), the lockless read is transformed to a
-   full locking read and no retry loop is necessary::
+   that trial fails (sequence counter doesn't match), make the marker
+   odd for the next iteration, the lockless read is transformed to a
+   full locking read and no retry loop is necessary, for example::
=20
 	/* marker; even initialization */
-	int seq =3D 0;
+	int seq =3D 1;
 	do {
+		seq++; /* 2 on the 1st/lockless path, otherwise odd */
 		read_seqbegin_or_lock(&foo_seqlock, &seq);
=20
 		/* ... [[read-side critical section]] ... */

