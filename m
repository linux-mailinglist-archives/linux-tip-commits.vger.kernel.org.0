Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0EEE3A3E41
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jun 2021 10:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhFKIsy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 11 Jun 2021 04:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhFKIsx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 11 Jun 2021 04:48:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88BAC061574;
        Fri, 11 Jun 2021 01:46:55 -0700 (PDT)
Date:   Fri, 11 Jun 2021 08:46:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623401212;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uHoTjvbKgdq91BgeexXp23EMh87O3DOd4hvm7/wcI5g=;
        b=mHZM8ATTbmptNUEb/tf/eBFNhIE+JJMQ09yw1OeMl3RWM5H7GSImrifu2KHgxybg3SUo9C
        1CTLULva/RkjfTzoVRywYtb1Rd0S5qi/8+paUL5DkMVtgAXmiExuW5oZBucDd07G7xWTRR
        PeZ1r/9ktS9Wbrnve27znYdkr71ZsEVHT4dJzZTkX60Lc+5Z5VIE/bCwUBFb8QBJi0P1yW
        DWAXSf2AgaP4M1isaatYq+uxgoI5Mjsdwt4E12xbR8xpxhkFWNvTfWVzwrmA8qSEJYmxbz
        K8y2Q8EiW/KHggtqVLG098zjrtaDyqVZwkmyAvpaVsj/UN23rnjdb9ZZumlwwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623401212;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uHoTjvbKgdq91BgeexXp23EMh87O3DOd4hvm7/wcI5g=;
        b=dxMQKhxGYzs8n8O5MnzxwC5zPGSCj9mYddI5LH1oRVVpHgmCzzwDeVmYr+eofv8NlWd6l6
        LuCLzLH44zLGGMAA==
From:   "tip-bot2 for ChenXiaoSong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/sgx: Correct kernel-doc's arg name in
 sgx_encl_release()
Cc:     ChenXiaoSong <chenxiaosong2@huawei.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210609035510.2083694-1-chenxiaosong2@huawei.com>
References: <20210609035510.2083694-1-chenxiaosong2@huawei.com>
MIME-Version: 1.0
Message-ID: <162340121120.19906.7609882843709493893.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     1d3156396cf6ea0873145092f4e040374ff1d862
Gitweb:        https://git.kernel.org/tip/1d3156396cf6ea0873145092f4e040374ff1d862
Author:        ChenXiaoSong <chenxiaosong2@huawei.com>
AuthorDate:    Wed, 09 Jun 2021 11:55:10 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 11 Jun 2021 10:42:38 +02:00

x86/sgx: Correct kernel-doc's arg name in sgx_encl_release()

Fix the following kernel-doc warning:

  arch/x86/kernel/cpu/sgx/encl.c:392: warning: Function parameter \
    or member 'ref' not described in 'sgx_encl_release'

 [ bp: Massage commit message. ]

Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210609035510.2083694-1-chenxiaosong2@huawei.com
---
 arch/x86/kernel/cpu/sgx/encl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 3be2032..001808e 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -383,7 +383,7 @@ const struct vm_operations_struct sgx_vm_ops = {
 
 /**
  * sgx_encl_release - Destroy an enclave instance
- * @kref:	address of a kref inside &sgx_encl
+ * @ref:	address of a kref inside &sgx_encl
  *
  * Used together with kref_put(). Frees all the resources associated with the
  * enclave and the instance itself.
