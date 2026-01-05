Return-Path: <linux-tip-commits+bounces-7801-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6AFCF493C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 17:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D9E3307CD31
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 16:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEF9346AC5;
	Mon,  5 Jan 2026 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="43JGmc1A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LQte9QUI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D762E346A09;
	Mon,  5 Jan 2026 15:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628470; cv=none; b=K71MitJH2p4oLJc1KDDe7FNLayuuqikKFB4VWI19m97rxrnSAZLJPeV5WZwL+1hMvy4prFcondEzrQW9R0NrZYzhr8v/XQcbJuOTFwz9/tJI47kkqazMT9Zun6KWC9xdsrx1e2oEpkYpXn5+DG3W3O9ujHEtJapeJgL+uys55+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628470; c=relaxed/simple;
	bh=Y2OZ//pU8p66LrkHA5gzpyxJb5ntYk2KS3tcPrpNQQ4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bXDV63jUy7qYclckRn4Q6GbcY76GJivbzLa/ZtwsShzt21MGiP/4+7LJLp9a6cUcof7p89nOWeXZzfdRARYcmbwMlnmx8pUravVRyaEWzgjEXkxz2ntSJuaQkYibPv/OzIA+/XUBKlqj9v69JXSJp3PhP4Dug3EOlzTKH1D+Nm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=43JGmc1A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LQte9QUI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 15:54:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767628467;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CD+qcmDRtwDRXjpgjQ9aWPwhW7CDD+Bitx14g+mhwH8=;
	b=43JGmc1A08LKda38CVUX97i1ul4IUDEP1/9W4YSSUtT45KkGF/Ji6rB51BCYb261KjZbV9
	ZMJGG4o+AI7uxhOZtTpcOtRExtl4etihsUBy5NtbGysxfEDwOUtEZqG0JdfA22vE/nSxLQ
	juyj8LzRHMm2HcggOsoTdtJKyJqA/6Vt27smD7EzbjeY703YQ6H8u4dwup+2WtrFmrMxab
	cku5Wq2gCbpqyzcsImN6MPnnXsKDfD6YEbQdvQnznfvHZ8HPsDoxtE50OxtDSSlvjifCZ3
	OYCpK8Un2Pn48tSa3xMffG9R4sRnYt6CS9y7HIkaDDE835fwEHpVziM4jtKtYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767628467;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CD+qcmDRtwDRXjpgjQ9aWPwhW7CDD+Bitx14g+mhwH8=;
	b=LQte9QUIpqH4HVXoYXGScXVJm7h5IDBq0YpAJVJEbCIuXe8n5Cz0oCYQyNvsabaiyFP6w1
	AV+pZS7+dSdqVPBA==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] debugfs: Make debugfs_cancellation a context lock struct
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Bart Van Assche <bvanassche@acm.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251219154418.3592607-22-elver@google.com>
References: <20251219154418.3592607-22-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176762846621.510.17459515291167261011.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     6e530e2e31191d88f692e6c8d3bd245e43416e4f
Gitweb:        https://git.kernel.org/tip/6e530e2e31191d88f692e6c8d3bd245e434=
16e4f
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 19 Dec 2025 16:40:10 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jan 2026 16:43:32 +01:00

debugfs: Make debugfs_cancellation a context lock struct

When compiling include/linux/debugfs.h with CONTEXT_ANALYSIS enabled, we
can see this error:

./include/linux/debugfs.h:239:17: error: use of undeclared identifier 'cancel=
lation'
  239 | void __acquires(cancellation)

Move the __acquires(..) attribute after the declaration, so that the
compiler can see the cancellation function argument, as well as making
struct debugfs_cancellation a real context lock to benefit from Clang's
context analysis.

This change is a preparatory change to allow enabling context analysis
in subsystems that include the above header.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20251219154418.3592607-22-elver@google.com
---
 include/linux/debugfs.h | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 7cecda2..4177c47 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -239,18 +239,16 @@ ssize_t debugfs_read_file_str(struct file *file, char _=
_user *user_buf,
  * @cancel: callback to call
  * @cancel_data: extra data for the callback to call
  */
-struct debugfs_cancellation {
+context_lock_struct(debugfs_cancellation) {
 	struct list_head list;
 	void (*cancel)(struct dentry *, void *);
 	void *cancel_data;
 };
=20
-void __acquires(cancellation)
-debugfs_enter_cancellation(struct file *file,
-			   struct debugfs_cancellation *cancellation);
-void __releases(cancellation)
-debugfs_leave_cancellation(struct file *file,
-			   struct debugfs_cancellation *cancellation);
+void debugfs_enter_cancellation(struct file *file,
+				struct debugfs_cancellation *cancellation) __acquires(cancellation);
+void debugfs_leave_cancellation(struct file *file,
+				struct debugfs_cancellation *cancellation) __releases(cancellation);
=20
 #else
=20

