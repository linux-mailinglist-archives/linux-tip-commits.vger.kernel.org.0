Return-Path: <linux-tip-commits+bounces-7919-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E47F6D18361
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 22E43301D2CB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04FF38A2A7;
	Tue, 13 Jan 2026 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Oc0OgnKT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xFF6/5l6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F3A38BF89;
	Tue, 13 Jan 2026 10:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301395; cv=none; b=NG24b6w5y9wN9y8iVc6tghkjKyCNuRJj+TxRtkWru4Ti7uj+DXZmpSabqkIMn8oNIuYHit/d1OUdKodlVTqeIfkXCol/+sp427QqgvxyKuqKCI563zVbDuojVkyi0u7zADdLrwUkg+yp/L08qIJZ5OepN6f6K0jMf8GiKcm16VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301395; c=relaxed/simple;
	bh=MR8G4vazDXR/XnhOfFWx3gxd1cJUvGTfPI42SjbDJlw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hlE3tp+JowNM/GaYc6GvwoPXV+xLLA73jI6BFBzTjKQZVp4Bo8q9DE31UtphHZ0wjJNxHZBpWYQ5WhIZhTL9Y2udhisUo03nxRZzQ6xun/pLO33ncTkCCgJak7cVK0FtCc12uO9K3SIteje+zuBVVevfjQNhQvz0zseGDmrfj8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Oc0OgnKT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xFF6/5l6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:49:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301387;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/ZJtZAD6Xb07ZZbBnlJ6TcLH36vgxm0UasFl4gKRo4=;
	b=Oc0OgnKTYaHNB2II1gk5L8lOwc7uyl1noabKcNf3M1sqjs1I3+KIGEt+VNIMi3LAXuzeGY
	p++xDQ4e2P+pYnL7uIXkPF191hrysB/JKzvgrATtMiNwlA33kiFHgilPO9GiNin6CbW3hA
	E62gD1AbvWwUHsbXbQ0zeVeEEueJIIVi40rfkxrkLukvcCz6IkM5CUZgxtLhXREoGvkeWk
	f51QoPw+6UIb7nfSmULp3nOq2qMvDMsIXZlhqeKfQ1An7+MlRyvAjs8m9vnN1g7GjVs/Rm
	i4fOIv5DkymAsppY38Hqsevd4AFM8zrwnA2L94w6H2yGto9Xzh3TOXBFuPEtPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301387;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/ZJtZAD6Xb07ZZbBnlJ6TcLH36vgxm0UasFl4gKRo4=;
	b=xFF6/5l6KaeB/WxEPCsP0pif0FDlDpUNbAwiJnBo76Uq697/E5l0KD6o8+HTcEQ9MMPlS0
	f7rvF5Pft944hHBQ==
From: "tip-bot2 for Alice Ryhl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: blk: Add __rust_helper to helpers
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 Alice Ryhl <aliceryhl@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260105-define-rust-helper-v2-2-51da5f454a67@google.com>
References: <20260105-define-rust-helper-v2-2-51da5f454a67@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830138640.510.5560955100510490447.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     71a4d13fa1cf2b7a4f45a6ee41548c27783f7940
Gitweb:        https://git.kernel.org/tip/71a4d13fa1cf2b7a4f45a6ee41548c27783=
f7940
Author:        Alice Ryhl <aliceryhl@google.com>
AuthorDate:    Mon, 05 Jan 2026 12:42:15=20
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:41 +08:00

rust: blk: Add __rust_helper to helpers

This is needed to inline these helpers into Rust code.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20260105-define-rust-helper-v2-2-51da5f454a67@=
google.com
---
 rust/helpers/blk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/helpers/blk.c b/rust/helpers/blk.c
index cc9f4e6..20c512e 100644
--- a/rust/helpers/blk.c
+++ b/rust/helpers/blk.c
@@ -3,12 +3,12 @@
 #include <linux/blk-mq.h>
 #include <linux/blkdev.h>
=20
-void *rust_helper_blk_mq_rq_to_pdu(struct request *rq)
+__rust_helper void *rust_helper_blk_mq_rq_to_pdu(struct request *rq)
 {
 	return blk_mq_rq_to_pdu(rq);
 }
=20
-struct request *rust_helper_blk_mq_rq_from_pdu(void *pdu)
+__rust_helper struct request *rust_helper_blk_mq_rq_from_pdu(void *pdu)
 {
 	return blk_mq_rq_from_pdu(pdu);
 }

