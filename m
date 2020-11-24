Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADFEB2C230B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Nov 2020 11:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbgKXKe6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Nov 2020 05:34:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42500 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgKXKe6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Nov 2020 05:34:58 -0500
Date:   Tue, 24 Nov 2020 10:34:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606214096;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XK6IZldHbKtlWSM+ZOqC4N5KU5SFrw/D0UJVgqUYpck=;
        b=NIJE6vcuB6AdlsHgVOA9xj6f1XFK+HG3+gpDSaKoAuBuJqRI7Y4q+0c54vkZMS+/6u69gR
        15k9+Ius+o+rK05rdSX7MYTtqssQxyIpA+U147MoradSBw1sUue1VG4itKkhwAKMpDz+CH
        6uW0SiHCP0qw/flGOsv+1lE+ETqBT/dkS3nwxb6yPGSuPrGuqTX3Nz+LD5K3VLYpE+GIHQ
        4GhmPquIoHnc6sxbi46C9AyqMcsykGdDpTVCOGtP7bN6PV19F1Q9mFoxxz/x+NHsW8XjEU
        WCLl7UZopOUcqkL4n1fsyAUDud3awCheIboZ+KwDjQGmHXgq2XplHHX/qV/UtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606214096;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XK6IZldHbKtlWSM+ZOqC4N5KU5SFrw/D0UJVgqUYpck=;
        b=j2LZpxfR1UcpMJrDRUFOTviYvV9K8ZslQ30ye77c0gvpB/obK9SlqZvQMk8QLpIcSXtBhS
        2tEHiMthiv3H+8CQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Fix sgx_ioc_enclave_provision() kernel-doc comment
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201123181922.0c009406@canb.auug.org.au>
References: <20201123181922.0c009406@canb.auug.org.au>
MIME-Version: 1.0
Message-ID: <160621409509.11115.5086990104401029239.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     afe76eca862ccde2a0c30105fc97a46a0b59339b
Gitweb:        https://git.kernel.org/tip/afe76eca862ccde2a0c30105fc97a46a0b59339b
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Mon, 23 Nov 2020 11:11:17 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 24 Nov 2020 10:46:01 +01:00

x86/sgx: Fix sgx_ioc_enclave_provision() kernel-doc comment

Fix

  ./arch/x86/kernel/cpu/sgx/ioctl.c:666: warning: Function parameter or member \
	  'encl' not described in 'sgx_ioc_enclave_provision'
  ./arch/x86/kernel/cpu/sgx/ioctl.c:666: warning: Excess function parameter \
	  'enclave' description in 'sgx_ioc_enclave_provision'

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201123181922.0c009406@canb.auug.org.au
---
 arch/x86/kernel/cpu/sgx/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 30aefc9..c206aee 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -652,7 +652,7 @@ out:
 
 /**
  * sgx_ioc_enclave_provision() - handler for %SGX_IOC_ENCLAVE_PROVISION
- * @enclave:	an enclave pointer
+ * @encl:	an enclave pointer
  * @arg:	userspace pointer to a struct sgx_enclave_provision instance
  *
  * Allow ATTRIBUTE.PROVISION_KEY for an enclave by providing a file handle to
