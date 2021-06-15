Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F0C3A8630
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Jun 2021 18:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhFOQSb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 15 Jun 2021 12:18:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34564 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhFOQSa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 15 Jun 2021 12:18:30 -0400
Date:   Tue, 15 Jun 2021 16:16:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623773785;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M5Q1bOWCXNG1RdlF3+TFXB+4Pmcf8M8iAAMMgbFcUfg=;
        b=cTb7Gq2FoOuZj/eBUHTyutpG230n1Yz42C4/3GGbJTZxjFLNuvnUexB/7MEMf5EcD+z2F1
        DZ61yOH84aBfaKMiziglTepkkNkAR4KhJUt2VeNX17A/IL2fr3T6QYtkbnXRCT2X49Mwcp
        48Nj2oF1nDYmOFt6Z/uRmrtdTVfCu+X7NydIPkryTzUgCnGJhClT7Xt54o4TRWD71ElSo+
        8h8fG8oPpt7JutFkCUz/4oD4RWQNH7a9tA5EGT0tKLHL3FH9lW0TzVehiYlj0Q0L6LW2tE
        hxlqMgAalRCWR/TBHWN1W4HKLFVoM+89QvBK4kKwz3kl1T+z3gRGgkiksVR1fA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623773785;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M5Q1bOWCXNG1RdlF3+TFXB+4Pmcf8M8iAAMMgbFcUfg=;
        b=Bgsum64ihfSJ37CzC4yoCwg1zi4Dxe7xhMZEEmm8vDMOl1N8IjNooBX6vkp6xMYHAfgjEz
        NraAv28LwJvP0qCA==
From:   "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sgx: Add missing xa_destroy() when virtual EPC
 is destroyed
Cc:     Kai Huang <kai.huang@intel.com>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Yang Zhong <yang.zhong@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210615101639.291929-1-kai.huang@intel.com>
References: <20210615101639.291929-1-kai.huang@intel.com>
MIME-Version: 1.0
Message-ID: <162377378414.19906.6678244614782222506.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     4692bc775d2180a937335ccba0edce557103d44a
Gitweb:        https://git.kernel.org/tip/4692bc775d2180a937335ccba0edce557103d44a
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Tue, 15 Jun 2021 22:16:39 +12:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 15 Jun 2021 18:03:45 +02:00

x86/sgx: Add missing xa_destroy() when virtual EPC is destroyed

xa_destroy() needs to be called to destroy a virtual EPC's page array
before calling kfree() to free the virtual EPC. Currently it is not
called so add the missing xa_destroy().

Fixes: 540745ddbc70 ("x86/sgx: Introduce virtual EPC for use by KVM guests")
Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Tested-by: Yang Zhong <yang.zhong@intel.com>
Link: https://lkml.kernel.org/r/20210615101639.291929-1-kai.huang@intel.com
---
 arch/x86/kernel/cpu/sgx/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/sgx/virt.c b/arch/x86/kernel/cpu/sgx/virt.c
index 6ad165a..64511c4 100644
--- a/arch/x86/kernel/cpu/sgx/virt.c
+++ b/arch/x86/kernel/cpu/sgx/virt.c
@@ -212,6 +212,7 @@ static int sgx_vepc_release(struct inode *inode, struct file *file)
 		list_splice_tail(&secs_pages, &zombie_secs_pages);
 	mutex_unlock(&zombie_secs_pages_lock);
 
+	xa_destroy(&vepc->page_array);
 	kfree(vepc);
 
 	return 0;
