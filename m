Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A012328046A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Oct 2020 18:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbgJAQ7s (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 1 Oct 2020 12:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732107AbgJAQ7s (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 1 Oct 2020 12:59:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4FEC0613D0;
        Thu,  1 Oct 2020 09:59:48 -0700 (PDT)
Date:   Thu, 01 Oct 2020 16:59:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601571585;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h2viArEXynjFH7Vx0/SFoYIVa4IC3HY4Q4jMKRoLIe4=;
        b=p5qF1xaQ0fFExDh4PlL9+elXzzstA881bkj8pNbMUibeQ1nhXpZ5vzFsEqwfABsrCZLse8
        /UIHvyDkhnIanatDJgQgAOI3ipNF5x3LVcWM181UZnOmjhHd8aIS8spLNzmNwF6KvrdyEx
        8FzBzto1oPI79TOECbbTxIxHADU/A3ZHRcOPJa/kG9lt0xHpTLdqPaGC7cghf+JczFjdTn
        H89R0Lqt5vYaBgOD9HUK6GLhYgzfJFMy52Rxu0YVoDGhvekMGg3ARCwuoHzgl9YYezwFUI
        G4QToGHPKsbjs8q7yw3B4C+aGj8+xlDp+wKYnFzVBJc6Z0sF6nWdMKc/om7jww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601571585;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h2viArEXynjFH7Vx0/SFoYIVa4IC3HY4Q4jMKRoLIe4=;
        b=mBT75TPfmGGfGcZhlyBvOyLXqAbktZjWg/XF76NYx1wYXIg0XrtsVNLAgj0arIF03ahywt
        Ax7LRiRrXdWMAMAw==
From:   "tip-bot2 for Gustavo A. R. Silva" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/uv/time: Use a flexible array in struct
 uv_rtc_timer_head
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Steve Wahl <steve.wahl@hpe.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201001145608.GA10204@embeddedor>
References: <20201001145608.GA10204@embeddedor>
MIME-Version: 1.0
Message-ID: <160157158480.7002.8851684386361032723.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     a0947081af2ac9549e6ba19877456730713bde23
Gitweb:        https://git.kernel.org/tip/a0947081af2ac9549e6ba19877456730713=
bde23
Author:        Gustavo A. R. Silva <gustavoars@kernel.org>
AuthorDate:    Thu, 01 Oct 2020 09:56:08 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 01 Oct 2020 18:47:39 +02:00

x86/uv/time: Use a flexible array in struct uv_rtc_timer_head

There is a regular need in the kernel to provide a way to declare having
a dynamically sized set of trailing elements in a structure. Kernel code
should always use =E2=80=9Cflexible array members=E2=80=9D[1] for these cases=
. The
older style of one-element or zero-length arrays should no longer be
used[2].

struct uv_rtc_timer_head contains a one-element array cpu[1]. Switch it
to a flexible array and use the struct_size() helper to calculate the
allocation size. Also, save some heap space in the process[3].

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.9-rc1/process/deprecated.html#zero-len=
gth-and-one-element-arrays
[3] https://lore.kernel.org/lkml/20200518190114.GA7757@embeddedor/

 [ bp: Massage a bit. ]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Steve Wahl <steve.wahl@hpe.com>
Link: https://lkml.kernel.org/r/20201001145608.GA10204@embeddedor
---
 arch/x86/platform/uv/uv_time.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/platform/uv/uv_time.c b/arch/x86/platform/uv/uv_time.c
index f82a133..6c348c2 100644
--- a/arch/x86/platform/uv/uv_time.c
+++ b/arch/x86/platform/uv/uv_time.c
@@ -52,7 +52,7 @@ struct uv_rtc_timer_head {
 	struct {
 		int	lcpu;		/* systemwide logical cpu number */
 		u64	expires;	/* next timer expiration for this cpu */
-	} cpu[1];
+	} cpu[];
 };
=20
 /*
@@ -148,9 +148,8 @@ static __init int uv_rtc_allocate_timers(void)
 		struct uv_rtc_timer_head *head =3D blade_info[bid];
=20
 		if (!head) {
-			head =3D kmalloc_node(sizeof(struct uv_rtc_timer_head) +
-				(uv_blade_nr_possible_cpus(bid) *
-					2 * sizeof(u64)),
+			head =3D kmalloc_node(struct_size(head, cpu,
+				uv_blade_nr_possible_cpus(bid)),
 				GFP_KERNEL, nid);
 			if (!head) {
 				uv_rtc_deallocate_timers();
