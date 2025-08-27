Return-Path: <linux-tip-commits+bounces-6383-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CFFB37AAF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Aug 2025 08:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08ED71B625AB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Aug 2025 06:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9E1314B66;
	Wed, 27 Aug 2025 06:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yx0peHnN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o6wYwuxb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D508D314A80;
	Wed, 27 Aug 2025 06:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277142; cv=none; b=fCLTaXIx28/2ILYgmzGHr8iXgEkVeea6y56bEyvMN8Q/DGz8MuxhYAtkAWpxZTbdQPpFzcnNwfZUGhydbIWGTWOmha74FcCmIAmg87SoG3RPk4RnhV6O9cFeJWVzdB8nbFqN/d9ucgeP08Cs9qwirKkkLYG4TUMxOYBXgr6vr7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277142; c=relaxed/simple;
	bh=7bT5SKk9aP5I3FmhwGVJFWD51V9/sXajPFBNiHu+C5U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FlYg6IYfQXexlgK7lXxB+MRSVyYrFQh2ejUkuLAZOlIO8Bk4jYcQJvzkLuF2dzZEUr7zHjRiZaD+55805prCkM1TfpwgFN2nzw1Gr/w/C22qKrQNIZ8FjcMp9Jq7NxLP6J60NyN/FqS+eRp5AJgB+6PHvFyoNrSf0oF9esHStCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yx0peHnN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o6wYwuxb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 27 Aug 2025 06:45:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756277139;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aeJhxlHbzKAGyrIpgbf51uwKFcRWTsHy/O1uRWX8VJ0=;
	b=yx0peHnNgLAZbL5XS3GgftdzKkuPe1+gyPhZ7NtBRLak/4+0LoIaaf1uB+cYhy/egVySYM
	P4rs+ZIHFPb7rGzSVOWro4jTLpwIox7T8oPhxk/O9LSVXLrMV+cv7Wv7WG7tqdM0/16Fae
	F4FvlsAdGbTQRKiCDJbviHhffsRrqVXqy0sxDOOCHyVkGdN3ikAg3Ya7Nun9kMgmYIcalS
	+eFyMSwmGGW4bpJ73vGGOy6xDNN44FZt67cWyISAWeJFdZB2javsmqw3Ory6/ab5E2uGQL
	1urDe0rpxfLv2t5eJQWWSakYEbK7Ayf/0qHDep2ndmh8uTARou/XGljZNkUV0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756277139;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aeJhxlHbzKAGyrIpgbf51uwKFcRWTsHy/O1uRWX8VJ0=;
	b=o6wYwuxbzqsem/vOGN46hQzGM64RMLWBjS87lF7KQaGzEHg894sWLLP5nmxebY/8/oTy+s
	f6TCeri34yX+/MCw==
From: "tip-bot2 for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/deadline: Fix dl_server_stopped()
Cc: Huacai Chen <chenhuacai@loongson.cn>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250809130419.1980742-1-chenhuacai@loongson.cn>
References: <20250809130419.1980742-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175627713711.1920.4925893907942675372.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     4717432dfd99bbd015b6782adca216c6f9340038
Gitweb:        https://git.kernel.org/tip/4717432dfd99bbd015b6782adca216c6f93=
40038
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Sat, 09 Aug 2025 21:04:19 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 26 Aug 2025 10:46:00 +02:00

sched/deadline: Fix dl_server_stopped()

Commit cccb45d7c429 ("sched/deadline: Less agressive dl_server handling")
introduces dl_server_stopped(). But it is obvious that dl_server_stopped()
should return true if dl_se->dl_server_active is 0.

Fixes: cccb45d7c429 ("sched/deadline: Less agressive dl_server handling")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250809130419.1980742-1-chenhuacai@loongson.=
cn
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e2d51f4..bb813af 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1611,7 +1611,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 static bool dl_server_stopped(struct sched_dl_entity *dl_se)
 {
 	if (!dl_se->dl_server_active)
-		return false;
+		return true;
=20
 	if (dl_se->dl_server_idle) {
 		dl_server_stop(dl_se);

