Return-Path: <linux-tip-commits+bounces-3734-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90893A497B3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Feb 2025 11:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D396171BC2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Feb 2025 10:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA75260374;
	Fri, 28 Feb 2025 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s2xIj3YQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oxTFayP7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF54817BA3;
	Fri, 28 Feb 2025 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740739653; cv=none; b=Mo+JugOSEh6boxyA7w0N/Ebsxr3/cuCyB3W5LWMhmhCM+08L/zjt++t65tBacLWDAw+AGKmW4F/aXxZJf7vWNzQx3Zh7DjMzRQL03fVr2BcAn0Wq6zMQlEd+9BjedH7OZOeJBPKAmGTKykSFfS8rT1CvBZvB23wcG+68FydcwcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740739653; c=relaxed/simple;
	bh=C6RkGAjW/jpeRwmN69ll2HAv/bzLwd2LE9e5Gg5iwrk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hdxZlAoFU6GPjfomm/AdBaXctDv4ZaNoYMUsmnZm3SzWDqYy+fkK0I09ABfi7PogjFbky0qte9u/Z0kHiMXidc/CrPkUkFd9ktWUyMua2AHvff0JdI3901vZ9E53p/OyJvbsmy99Wv+hWX0eIa7m4Vuro3JP29LhS7uV0FOgI5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s2xIj3YQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oxTFayP7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 28 Feb 2025 10:47:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740739649;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L9bAwxDS5Aj5RR+hNYnuonJEp5G6o7xcJiIunZtbbv0=;
	b=s2xIj3YQGSIgqmaX4HcDmfkmTN69QOzNNsfy92A++hdEhN51cFmfoOVRSJWCkIvmgZiCRQ
	bYkJEy3d6N82YzyR0y/O5jqO91QLUNbJcqUxn8NSyFmi4ssCXBYWnJpBmxZj49How361ZH
	wvcbyay2wUupxnwd9zfm/9hmpNR+nFIbINrP1YCFVgMrSZMUvRzFUd8QEPV8f25S38+R9O
	BMBY3Si8qkFOT6XHmLd2R9y75izcavS7ioW21FYUHmT1F0l4TQt8Ju0a3F7PdrzyVmmrhO
	Pbdkp9J85qF5O64GON7QF3WHeMPGsww3qw4VdlQRp80jMeHgncEutWt2bh6tkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740739649;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L9bAwxDS5Aj5RR+hNYnuonJEp5G6o7xcJiIunZtbbv0=;
	b=oxTFayP7VdHzj7lVuWHryRt7t3SYdrdsZVtcvQC6jwB8jsFgE9LKtPuVMUvDucYdg3hSvS
	FOrAOyZCQgNbXIDg==
From: "tip-bot2 for Youling Tang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Add
 bch2_trans_unlocked_or_in_restart_error() to bcachefs noreturns
Cc: k2ci <kernel-bot@kylinos.cn>, Youling Tang <tangyouling@kylinos.cn>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250218064230.219997-1-youling.tang@linux.dev>
References: <20250218064230.219997-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174073964873.10177.18098594447023695000.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     b4ae43b053537ec28f430c0ddb9b916ab296dbe5
Gitweb:        https://git.kernel.org/tip/b4ae43b053537ec28f430c0ddb9b916ab296dbe5
Author:        Youling Tang <tangyouling@kylinos.cn>
AuthorDate:    Tue, 18 Feb 2025 14:42:30 +08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 25 Feb 2025 10:16:31 -08:00

objtool: Add bch2_trans_unlocked_or_in_restart_error() to bcachefs noreturns

Fix the following objtool warning during build time:

  fs/bcachefs/btree_cache.o: warning: objtool: btree_node_lock.constprop.0() falls through to next function bch2_recalc_btree_reserve()
  fs/bcachefs/btree_update.o: warning: objtool: bch2_trans_update_get_key_cache() falls through to next function need_whiteout_for_snapshot()

bch2_trans_unlocked_or_in_restart_error() is an Obviously Correct (tm)
panic() wrapper, add it to the list of known noreturns.

Fixes: b318882022a8 ("bcachefs: bch2_trans_verify_not_unlocked_or_in_restart()")
Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>
Link: https://lore.kernel.org/r/20250218064230.219997-1-youling.tang@linux.dev
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/noreturns.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
index b217489..6bb7edd 100644
--- a/tools/objtool/noreturns.h
+++ b/tools/objtool/noreturns.h
@@ -19,7 +19,7 @@ NORETURN(__x64_sys_exit_group)
 NORETURN(arch_cpu_idle_dead)
 NORETURN(bch2_trans_in_restart_error)
 NORETURN(bch2_trans_restart_error)
-NORETURN(bch2_trans_unlocked_error)
+NORETURN(bch2_trans_unlocked_or_in_restart_error)
 NORETURN(cpu_bringup_and_idle)
 NORETURN(cpu_startup_entry)
 NORETURN(do_exit)

