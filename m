Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF692CDEEB
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Dec 2020 20:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgLCT0c (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 14:26:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42330 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbgLCT0c (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 14:26:32 -0500
Date:   Thu, 03 Dec 2020 19:25:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607023549;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RZgSh8ulagCA/7FmDyfnmfnmWn2C2Vjxl9GQe1i29TQ=;
        b=RY2Jje1tzPWjShpL+1oXIl3oz/QQAS3IkRHPtzeG5/3qv6WHoQYtXpAcUyNr74pASSmKUO
        7OnqmyxrMLMnNCaybnF5hfETRI9W0tV6dOjVDBsQ0g6nFglztDtyPmoxvBjej3Ebkaj1Va
        ozyIyOb3k2bXVW4YIeE3uD8hMsd7Ygfw6o+T5VGyDGbA2RSXtUIsiU2UlRm3dnrvp1gbuT
        KG6+Xx8p/DiFCReaaxhouxDFfltpevr4jNZa4MqU10QzFGDU3Bqohv/oUiZWikIsaSmfTE
        ffhVdwoptg51cN2XvCyE13jOP6eTurlu6/NWBg6KwMr7kS8TD8/Pl6QCcO5Fiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607023549;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RZgSh8ulagCA/7FmDyfnmfnmWn2C2Vjxl9GQe1i29TQ=;
        b=NqfmHeuISa6RQSMzpgDkqRlU20bSutozDODdRaL+WfWKOCTte+YrtCv0uBaO1p+D9W/y3P
        adrdawvTDS93WBCw==
From:   "tip-bot2 for Jarkko Sakkinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Return -EINVAL on a zero length buffer in
 sgx_ioc_enclave_add_pages()
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201203183527.139317-1-jarkko@kernel.org>
References: <20201203183527.139317-1-jarkko@kernel.org>
MIME-Version: 1.0
Message-ID: <160702354906.3364.11196477877749355876.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     a4b9c48b96517ff4780b22a784e7537eac5dc21b
Gitweb:        https://git.kernel.org/tip/a4b9c48b96517ff4780b22a784e7537eac5dc21b
Author:        Jarkko Sakkinen <jarkko@kernel.org>
AuthorDate:    Thu, 03 Dec 2020 20:35:27 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 03 Dec 2020 19:54:40 +01:00

x86/sgx: Return -EINVAL on a zero length buffer in sgx_ioc_enclave_add_pages()

The sgx_enclave_add_pages.length field is documented as

 * @length:     length of the data (multiple of the page size)

Fail with -EINVAL, when the caller gives a zero length buffer of data
to be added as pages to an enclave. Right now 'ret' is returned as
uninitialized in that case.

 [ bp: Flesh out commit message. ]

Fixes: c6d26d370767 ("x86/sgx: Add SGX_IOC_ENCLAVE_ADD_PAGES")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/linux-sgx/X8ehQssnslm194ld@mwanda/
Link: https://lkml.kernel.org/r/20201203183527.139317-1-jarkko@kernel.org
---
 arch/x86/kernel/cpu/sgx/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index c206aee..90a5caf 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -428,7 +428,7 @@ static long sgx_ioc_enclave_add_pages(struct sgx_encl *encl, void __user *arg)
 	    !IS_ALIGNED(add_arg.src, PAGE_SIZE))
 		return -EINVAL;
 
-	if (add_arg.length & (PAGE_SIZE - 1))
+	if (!add_arg.length || add_arg.length & (PAGE_SIZE - 1))
 		return -EINVAL;
 
 	if (add_arg.offset + add_arg.length - PAGE_SIZE >= encl->size)
