Return-Path: <linux-tip-commits+bounces-2837-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8E79C3C8F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 Nov 2024 11:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE821C20CEF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 Nov 2024 10:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A70A176FB6;
	Mon, 11 Nov 2024 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NvXYl6Kt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/zpH/BIP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B082417BECA;
	Mon, 11 Nov 2024 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731322770; cv=none; b=kk7xHzbSAkiOPe9pIP2Zme3hT/qdSr1zx4B0CJQekewIwCRrL1ygSXCrvNIkKNc5YiO0LIfv0FwR/5LAZc5iUH3y2GFjwq9EbUEcO/GdBgU8TBMoKLVX6NfLDJ0VFnyIqPWDByCig0Qr+jmaXBWHW5jnH8u7YBIBaAI8scXJ7DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731322770; c=relaxed/simple;
	bh=+YsuAWwMtnlD3Q5cRdx7psix1M4qBlk9fGvHL1vdy8g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PqGb0N9AOpinMs698qdXhFNkQw9A6qqimtN7FnyBGe6rxVobr6edrl2qHsR97+JkRhiGTVviXNF6YPFZNLwodLgoZV11KTM5j8QtNWIg7YloTkweRGintXBm/nq1lzVoO5sBWXpMjBCLGyZWxLvct8HqppWhUtFueyHPJc4maUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NvXYl6Kt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/zpH/BIP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 11 Nov 2024 10:59:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731322765;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZrKxPWBHu8DIXF3QMFDgmVEtzCTtk54Bt6QpwP1VDes=;
	b=NvXYl6Kteqzg/ySv8Ny/m/g5DwRK7z6vbJ2evq2RFPGPpGKj0qzxoCegl0qnugDqms89dn
	WZlLKsefE/0nWQREaQnijFF/hIKq3XspkAXQhWqOzEKYizOjutChhrJhVX9qDXLOp8LCxD
	7GzkPP7JHkv+9+hoKcYFkT2N+2g0cY/05VzIcqVd485ozWT25/uHTFcOtyRpYTCZjjnRFw
	STHb11UmAOvjO8B0EgEpj94Ae4zE1Av/iplRPjz1uSImZClFyw43ssS6yQrVMgy6JUx1Ks
	0gOo87HXLWyhIxmwy1B8iNYukQq63hmzcDj/SZuxEcQs0Zh2wUIFCALazuY6UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731322765;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZrKxPWBHu8DIXF3QMFDgmVEtzCTtk54Bt6QpwP1VDes=;
	b=/zpH/BIPBlMaLaY8h83pfr9IIgKDG0VdHT5x6Fej85xVLFYwq7cqV7sfQR8VOYyoQUVH6m
	Se9HhkU7A6OQznDA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] objtool: Exclude __tracepoints data from ENDBR checks
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241108184618.GG38786@noisy.programming.kicks-ass.net>
References: <20241108184618.GG38786@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173132276382.32228.11223762940167419288.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     d5173f7537505315557d8580e3a648f07f17deda
Gitweb:        https://git.kernel.org/tip/d5173f7537505315557d8580e3a648f07f17deda
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 08 Nov 2024 10:32:02 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 11 Nov 2024 11:49:42 +01:00

objtool: Exclude __tracepoints data from ENDBR checks

For some, as of yet unexplained reason, Clang-19, but not GCC,
generates and endless stream of:

drivers/iio/imu/bno055/bno055_ser.o: warning: objtool: __tracepoint_send_chunk+0x20: data relocation to !ENDBR: __SCT__tp_func_send_chunk+0x0
drivers/iio/imu/bno055/bno055_ser.o: warning: objtool: __tracepoint_cmd_retry+0x20: data relocation to !ENDBR: __SCT__tp_func_cmd_retry+0x0
drivers/iio/imu/bno055/bno055_ser.o: warning: objtool: __tracepoint_write_reg+0x20: data relocation to !ENDBR: __SCT__tp_func_write_reg+0x0
drivers/iio/imu/bno055/bno055_ser.o: warning: objtool: __tracepoint_read_reg+0x20: data relocation to !ENDBR: __SCT__tp_func_read_reg+0x0
drivers/iio/imu/bno055/bno055_ser.o: warning: objtool: __tracepoint_recv+0x20: data relocation to !ENDBR: __SCT__tp_func_recv+0x0

Which is entirely correct, but harmless. Add the __tracepoints section
to the exclusion list.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20241108184618.GG38786@noisy.programming.kicks-ass.net
---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7fc96c3..f7586f8 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4573,6 +4573,7 @@ static int validate_ibt(struct objtool_file *file)
 		    !strcmp(sec->name, "__jump_table")			||
 		    !strcmp(sec->name, "__mcount_loc")			||
 		    !strcmp(sec->name, ".kcfi_traps")			||
+		    !strcmp(sec->name, "__tracepoints")			||
 		    strstr(sec->name, "__patchable_function_entries"))
 			continue;
 

