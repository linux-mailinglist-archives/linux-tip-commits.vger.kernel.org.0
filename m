Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7C5427ACB
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Oct 2021 16:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbhJIOZl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 9 Oct 2021 10:25:41 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59732 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbhJIOZk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 9 Oct 2021 10:25:40 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id ADA2F1F44CD3
Message-ID: <6d99ad7a-8f2a-90af-7dc4-3d763413e045@collabora.com>
Date:   Sat, 9 Oct 2021 11:23:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [tip: locking/core] futex: Move to kernel/futex/
Content-Language: en-US
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-tip-commits@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210923171111.300673-2-andrealmeid@collabora.com>
 <163377403828.25758.17995844716836790939.tip-bot2@tip-bot2>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
In-Reply-To: <163377403828.25758.17995844716836790939.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Hi Peter,

Às 07:07 de 09/10/21, tip-bot2 for Peter Zijlstra escreveu:
> The following commit has been merged into the locking/core branch of tip:
> 
> Commit-ID:     77e52ae35463521041906c510fe580d15663bb93
> Gitweb:        https://git.kernel.org/tip/77e52ae35463521041906c510fe580d15663bb93
> Author:        Peter Zijlstra <peterz@infradead.org>
> AuthorDate:    Thu, 23 Sep 2021 14:10:50 -03:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Thu, 07 Oct 2021 13:51:07 +02:00
> 
> futex: Move to kernel/futex/
> 
> In preparation for splitup..
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: André Almeida <andrealmeid@collabora.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: André Almeida <andrealmeid@collabora.com>
This Signed-off-by chain seems odd, all patches to 15/22 have this, is
it right?
