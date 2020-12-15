Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6CBE2DABBE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Dec 2020 12:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgLOLRx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 15 Dec 2020 06:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728574AbgLOLRp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 15 Dec 2020 06:17:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7167DC0617B0;
        Tue, 15 Dec 2020 03:17:04 -0800 (PST)
Date:   Tue, 15 Dec 2020 11:17:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608031022;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i/0rGN5F/05Z24k5Cr5f3SEE9oS86nFjhXC4QTU6TPA=;
        b=KPeNKS/GUgn4qjOJPMP2nG8+e7mo6cjMFBvbUnNMGInI3G7e+lhW/HgH41M1bejEgl4oHR
        LPUHUamiwpXcYhHrQBaPgf3scTXsuG6r6/nsWUyYeFDfZjC+5AUg9oZKWp9/oZ1ShYO0C7
        seVVjpC0PeypHzbqoWbMGfuoTkEBaMPsik/PnTu3D4cO7zMLqCbLDj3evwWGIzM4bms7Vd
        EpzuTd/Yd06kk79d3o2tCINium9faLzWBMrSohjS2YhBYQXLKWwG/P2EM+FuUm4KQBWziB
        Snzo93ItVVhNsxjl177zYRb31Gb5fPEUb4ZzEYwdbc765XpVFiw0BcbCFf/7HQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608031022;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i/0rGN5F/05Z24k5Cr5f3SEE9oS86nFjhXC4QTU6TPA=;
        b=llKlue3Xc2RJIVin0rcisq9DpIZln9G9zcx3Qw/7TXLsA6lS2ro5vp8p1TlP0b2LZXph0M
        Z3UQU1U9y5wcORAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] Merge tag 'efi-next-for-v5.11-3' of
 git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi into efi/core
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201215080144.17077-1-ardb@kernel.org>
References: <20201215080144.17077-1-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <160803102189.3364.4923152997759150061.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     3dcb8b53cbd2cc5618863b19ef00f8ea82f27e83
Gitweb:        https://git.kernel.org/tip/3dcb8b53cbd2cc5618863b19ef00f8ea82f27e83
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 15 Dec 2020 12:14:38 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Dec 2020 12:14:38 +01:00

Merge tag 'efi-next-for-v5.11-3' of git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi into efi/core

Pull followup fixes for EFI from Ard Biesheuvel:

 - fix the build breakage on IA64 caused by recent capsule loader changes

 - suppress a type mismatch build warning in the expansion of
   EFI_PHYS_ALIGN on ARM

Link: https://lore.kernel.org/r/20201215080144.17077-1-ardb@kernel.org
---
