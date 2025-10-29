Return-Path: <linux-tip-commits+bounces-7084-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E811C19C3C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 11:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC9BA1C66AF8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EED934AB09;
	Wed, 29 Oct 2025 10:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gzMMsOpT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fvUxYK3X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE16934A775;
	Wed, 29 Oct 2025 10:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733448; cv=none; b=q1OYurreHBmEinr5N8z14W9xgRf25wR2ea08li3cRhfML3aIz3mTKyt+hNcuqNhIcDvrtjocPyzhDqP7QsdLDAEqGs1UPXgvimFSs5XV4YV9XweUvF5s4waCn52aNFcsvQKgwSE3vBqhUCLRlsTr9H1+kE0VG+278rFJQn3qFZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733448; c=relaxed/simple;
	bh=eey6kWvzLyl5LGjxw0V9pbLw/7zxw+oOaOp8rbcX8Lg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=slJvNlg09XmjtZWGD6aqhBlCyp1o0Tdi6uc542YOzXK76sw2bytwJy4I+9aSo2myNSDh9gZKEJZdrZevRroVjbsLZpxtkvi6zVksv7qBFypKwBoO8H4pwGmwXwNk41Z3lFmYfJBy+0zIBeWzTQD6jJgGwLUobh7G7jxfks4xckw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gzMMsOpT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fvUxYK3X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 10:24:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761733445;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1YgfPv8aUQ1T5ingvSVzJl8AasTUzF30cfJYRm0vUCo=;
	b=gzMMsOpTJh+xMTzvXOuZTubLNuBzKj5bEH1PVQ0hZ64qIaI/C/DU6Y4r4MNC5jru6JEbi1
	HYBX2H9eamxKMdAMg30/BY+z+p0VEjDQX46V0d3KUkygm/QBBKQOKIf/RhsmjYf78GhQRT
	4PN3mIFRGs8hIt70nkt/dB9b20s1IaKMOOgd9XgHoUOkKdAb5P4maN7g7Pw0rh1HjUJ5GQ
	1uXkmA3RN2Bg5ALavdjhwO7X23cv1Vu2wmJygLCKdv+XKu9gta6aXKW49ej1QxYP6gCfC5
	pF1xkj9Yd9guaGpLKdjH+8fEFjzUNckvpYbqviDP5pXjcSCk1aszVRSE5CvZWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761733445;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1YgfPv8aUQ1T5ingvSVzJl8AasTUzF30cfJYRm0vUCo=;
	b=fvUxYK3XQvmpOz6wA9hcNVVp8TBpDLuN38Vv6AtKSOno2TutFruJAHcXt/yrfKiiavRRrT
	Wt8ggbYXF47/O6Cg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] select: Convert to scoped user access
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027083745.862419776@linutronix.de>
References: <20251027083745.862419776@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173344420.2601451.6354293973777581051.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     9ba7c9a6b2ff2424a4035403fc12c948efdcff0a
Gitweb:        https://git.kernel.org/tip/9ba7c9a6b2ff2424a4035403fc12c948efd=
cff0a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:04 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 11:07:10 +01:00

select: Convert to scoped user access

Replace the open coded implementation with the scoped user access guard.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027083745.862419776@linutronix.de
---
 fs/select.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 082cf60..65019b8 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -776,17 +776,13 @@ static inline int get_sigset_argpack(struct sigset_argp=
ack *to,
 {
 	// the path is hot enough for overhead of copy_from_user() to matter
 	if (from) {
-		if (can_do_masked_user_access())
-			from =3D masked_user_access_begin(from);
-		else if (!user_read_access_begin(from, sizeof(*from)))
-			return -EFAULT;
-		unsafe_get_user(to->p, &from->p, Efault);
-		unsafe_get_user(to->size, &from->size, Efault);
-		user_read_access_end();
+		scoped_user_read_access(from, Efault) {
+			unsafe_get_user(to->p, &from->p, Efault);
+			unsafe_get_user(to->size, &from->size, Efault);
+		}
 	}
 	return 0;
 Efault:
-	user_read_access_end();
 	return -EFAULT;
 }
=20

