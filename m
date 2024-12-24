Return-Path: <linux-tip-commits+bounces-3145-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2E19FC18D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 19:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C05E07A00AE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 18:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FF91D9587;
	Tue, 24 Dec 2024 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ede3v/JT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hb1hl9+I"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2865C212D64;
	Tue, 24 Dec 2024 18:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735066512; cv=none; b=lhhRCOXWMQ+crFmXuCBWQgXkraNhus30NBVXXlRd7uvfwxK/9l7OCC7y/zUBUB+V/vcxiqanx9+qHm+YdS8Q7yqMte5m4EDm4utAIcEQS1Di3COMfu54bsidTPHZSRdSiBzRYMerDPYKriG+jj0T5eOaMmLxi4IzRRypbFsaGfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735066512; c=relaxed/simple;
	bh=9u3BPVJclxL1qyjcaxqjy8hAP7iCnKpkbdk1qr3RiJ4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ec7uH1hwpu3Ia98N3FGSFNmk/I2DKLvpgGR6tDKhz9Tkdc2mHa+7fZsb8c5Dq5MQu9u+q3qY3dJgzEId5w6thRDsHC6ZCcfiqvKAvF/OAII4D0UrQJAfVlebWSpt3y6tUBKRJj3BISkmRtwgTeyQkXOWh0OiEt/wqh/zY0Yxw7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ede3v/JT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hb1hl9+I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 18:55:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735066509;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KxqQVTgX/vyVTviK+i7yQWjF+Dj06/T19GXrfVHAqL0=;
	b=Ede3v/JTwNwKqi8kNr3qArqsYiEqsAf10kIS+0WKrz3lwyLoSW2jwqtQuVFhlKm8V4q34F
	b2fDM9sqq9IyCcgWwdRwvlt3RgsWyk4TCrHVoAh9bNwU7KrTZuyTBAeIrrtasetj6ijbnl
	DYk8fapFAmQCw+YJpdKMQMa6EbEhlXKdpB8JlOB4xpWlCrc6JcUIoszFJ5Wobjde6+vJnW
	RkMVRT8e+eqgTP3vCqi3Ech1oOh1C8dHAfI5Uevx4RHTKbDQNHXj5sSDizRG1FH4yLrTxS
	sYRcW2gWiDu2vDZPhac4ww8jXPlTT9lyTXhcOZ1anP0i7JRBNKFMUyLtzdCaDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735066509;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KxqQVTgX/vyVTviK+i7yQWjF+Dj06/T19GXrfVHAqL0=;
	b=hb1hl9+IQuXhh7wvHQIRAdykvZmOZXmNZBJxQNpLTs80QRoWqTVibkZZM+1hRwJKpSfqN8
	9joCH+7KqJHTm+AQ==
From: "tip-bot2 for chenchangcheng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: add bch2_trans_unlocked_error to
 bcachefs noreturns.
Cc: chenchangcheng <chenchangcheng@kylinos.cn>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241220074847.3418134-1-ccc194101@163.com>
References: <20241220074847.3418134-1-ccc194101@163.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173506650927.399.16674014518259045678.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     0b56a9cc3fcb4eb12c9f3592a052b8aff2d4a3ee
Gitweb:        https://git.kernel.org/tip/0b56a9cc3fcb4eb12c9f3592a052b8aff2d4a3ee
Author:        chenchangcheng <ccc194101@163.com>
AuthorDate:    Fri, 20 Dec 2024 15:48:47 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Dec 2024 15:31:26 +01:00

objtool: add bch2_trans_unlocked_error to bcachefs noreturns.

fix the following objtool warning during build time:
    fs/bcachefs/btree_trans_commit.o: warning: objtool: bch2_trans_commit_write_locked.isra.0() falls through to next function do_bch2_trans_commit.isra.0()
    fs/bcachefs/btree_trans_commit.o: warning: objtool: .text: unexpected end of section
......
    fs/bcachefs/btree_update.o: warning: objtool: bch2_trans_update_get_key_cache() falls through to next function flush_new_cached_update()
    fs/bcachefs/btree_update.o: warning: objtool: flush_new_cached_update() falls through to next function bch2_trans_update_by_path()

Fixes: fd104e2967b7 ("bcachefs: bch2_trans_verify_not_unlocked()")
Signed-off-by: chenchangcheng <chenchangcheng@kylinos.cn>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20241220074847.3418134-1-ccc194101@163.com
---
 tools/objtool/noreturns.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
index f37614c..b217489 100644
--- a/tools/objtool/noreturns.h
+++ b/tools/objtool/noreturns.h
@@ -19,6 +19,7 @@ NORETURN(__x64_sys_exit_group)
 NORETURN(arch_cpu_idle_dead)
 NORETURN(bch2_trans_in_restart_error)
 NORETURN(bch2_trans_restart_error)
+NORETURN(bch2_trans_unlocked_error)
 NORETURN(cpu_bringup_and_idle)
 NORETURN(cpu_startup_entry)
 NORETURN(do_exit)

