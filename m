Return-Path: <linux-tip-commits+bounces-7206-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5FAC2CD2F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 03 Nov 2025 16:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D12314609C1
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Nov 2025 15:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4B9320CC2;
	Mon,  3 Nov 2025 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BJm9N4nU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8qkOWYdg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6766320A0A;
	Mon,  3 Nov 2025 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181283; cv=none; b=N0yDRyazvkl6OY1nI9Gad0XWXKwj0njXucY0Nb8C3Gs9GHOevwnIHk72cPz8fwewd9HNSAf1RTac61APts8dnPV8cjm3FKthw9Z7W9DIDpaGNiMfvniI3PbIo4yl/iZB5BJuiu84PfrrpiabppD79UkZWf+H14iYti5RlOUeCtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181283; c=relaxed/simple;
	bh=zIEpE/puZx1rxt8BoEru9solqfsBYotferHeeQ4wmvs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BM4MR1aFEnAlRznI054NAa+VUH3VXb6LxAeDfIfwnT/f3Co4GKgobM52J3rqSvMrGQkY9TGI769B999OdqsO+cQTl8+sw9t0z/jJult864sg6edDFSHtPthw7L20DjBnF4F/sYo6J9eYiVy2xrvMJBm0ptuzZVFiR5UqLBJ6jTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BJm9N4nU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8qkOWYdg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Nov 2025 14:47:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762181280;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BNIRtlJYdIzlRDqJoYTghqBp6M5Zupw8X9K2XBwMyfs=;
	b=BJm9N4nUhOLz6oU69z35FOhqRBWGpqlbiiILrJ2hoaznho1AeID8OzudolTEJqXkbf5uih
	DqZswzm2mZQCWLVZm99eCUVkQwu0dpUpu2VWkQQKUnjajCML+1jcJzY7lrtuHFCLPgP5k6
	xWFPyoYGc3ASedd+0mp2kOieTCJLtRNQ6CNqv8hPhwZz/o5VNTy28ydcn6JYvJqtnZEF8T
	+dxOFbwXA8WWxKY6fSfJpqibWPk3eC92RcJjKzKgk2ad1zlPW3Gtfi9rxbgkhwG1f9wdmA
	Vs5vNlYUljjFUbd8MV9xC2l1uciiG0E7LFcX+q09xrlQQqptFWNyAQhXsR5HWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762181280;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BNIRtlJYdIzlRDqJoYTghqBp6M5Zupw8X9K2XBwMyfs=;
	b=8qkOWYdgaSy51hJFFa209Bapi6sh2dh/LVEA3Zalj8LxLxJ0wrEMHHllBUZfBTl9lfqVcI
	XfwXh7jVTfdFp/Dg==
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
Message-ID: <176218127910.2601451.7631394423002916236.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     6ec821f050e2e539cf3e57ff294d451c84a83aaf
Gitweb:        https://git.kernel.org/tip/6ec821f050e2e539cf3e57ff294d451c84a=
83aaf
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:04 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Nov 2025 15:26:12 +01:00

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

