Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0773E5540
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 10:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238207AbhHJIb2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 04:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238229AbhHJIb1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 04:31:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E919C061798;
        Tue, 10 Aug 2021 01:31:05 -0700 (PDT)
Date:   Tue, 10 Aug 2021 08:30:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628584260;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d6uhnwd+j4pKUYADK+DbulPKc29QE0gCPitqoiHHyVs=;
        b=2j+A9spZC1S7q/f/eTJdUmt5yePEPj9KJu7S6hCzt5WVBThp1z0fZzu9rHFSCH14DpiGJD
        STZsaSQkWxVtXYsAKF589CTDWiMlIdeRHKy9gD4JUY5qBaZ0w+dJfSWmH9XGjXPzdGQX9r
        17W4chsW0jqAPkCAKk0JAvuGqXq7lYV4r7AfuOC/apy4Eq1tIoTjPq9MbPmtAxbRvFGamH
        4EsyG2qVXPlLvRFQ0YweidOCnK0W2NnyAv97QMuNXxznjzLWvOUnQ19/Ybsn1HFDflx5Fm
        KzLoJNPj3rSGA1VIba7oqp9fMJbGbjsPKRle2jSF5Rx/PAQ4I+Li5vKg3FdMeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628584260;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d6uhnwd+j4pKUYADK+DbulPKc29QE0gCPitqoiHHyVs=;
        b=yt8cmCw45e/GQFUk+WuPUG0hZrmyMHBWKY2Ahi91QDefehudZQUGZaEoLnzlmhHxopFgZ5
        cJwmsFe0Ytx8P0Ag==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] Merge tag 'efi-urgent-for-v5.14-rc4' of
 git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi into efi/urgent
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210803091215.2566-1-ardb@kernel.org>
References: <20210803091215.2566-1-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <162858425996.395.3669943879889746012.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     55203550f9afb027389bd24ce85bd90044c3aa81
Gitweb:        https://git.kernel.org/tip/55203550f9afb027389bd24ce85bd90044c3aa81
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 10 Aug 2021 10:24:49 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 10:24:49 +02:00

Merge tag 'efi-urgent-for-v5.14-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi into efi/urgent

Pull EFI fixes from Ard Biesheuvel:

 A batch of fixes for the arm64 stub image loader:

 - fix a logic bug that can make the random page allocator fail
   spuriously
 - force reallocation of the Image when it overlaps with firmware
   reserved memory regions
 - fix an oversight that defeated on optimization introduced earlier
   where images loaded at a suitable offset are never moved if booting
   without randomization
 - complain about images that were not loaded at the right offset by the
   firmware image loader.

Link: https://lore.kernel.org/r/20210803091215.2566-1-ardb@kernel.org
---
