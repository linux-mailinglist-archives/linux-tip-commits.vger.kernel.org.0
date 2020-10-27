Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC78929C9B6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Oct 2020 21:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504323AbgJ0UHM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 27 Oct 2020 16:07:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48924 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502330AbgJ0UHL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 27 Oct 2020 16:07:11 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603829229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uLHasLeFZXHLGuB6wXRMCNndBw4TlZvcsyKqECXZETI=;
        b=xfsxAyU2PhzwTPwDpkO3DO2lsAZ8qOZjpv2wF+3QyeDsEWD1dLi4qDZw1jxHim3rD6xpjm
        80W0nwscc10SCZNET0z39+i+FMh9UTLyi7XCjEObzKt+qe36qNwGTDVDr8eNAmQSrXm6Ca
        GX0TfSxkbzIZ86XnFm00vm0QgpOMXtBRxAUNnI5UDGmqPtIbBgV/IjRPOPdMlsY62PjXQQ
        RHL6Piz12tlOwuCW9O3y1+Sm31+t/BLZQbDOLuq5sfN1QpUfPYSs3SqoKbRgrNYlsTlk5u
        +X3tcMtAOo5KcxnjuiSVpmJMhSkFFFJoR7uX29wWc6iCubSF8BwycjJEjebvLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603829229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uLHasLeFZXHLGuB6wXRMCNndBw4TlZvcsyKqECXZETI=;
        b=YNY8I2npi4rufzOpUNo9hn0uEGG0KJ3maGc5wBsl4uPgSUcUgEZF3JkvSIB4PI5Jp2JL25
        gsxwNNQdfm5QQxCw==
To:     tip-bot2 for Kairui Song <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org
Cc:     Kairui Song <kasong@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [tip: x86/urgent] x86/kexec: Use up-to-dated screen_info copy to fill boot params
In-Reply-To: <160269020077.7002.6607120194042289745.tip-bot2@tip-bot2>
References: <20201014092429.1415040-2-kasong@redhat.com> <160269020077.7002.6607120194042289745.tip-bot2@tip-bot2>
Date:   Tue, 27 Oct 2020 21:07:06 +0100
Message-ID: <877drb1lhx.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Oct 14 2020 at 15:43, tip-bot wrote:
> The following commit has been merged into the x86/urgent branch of tip:
> x86/kexec: Use up-to-dated screen_info copy to fill boot params
>
> kexec_file_load() currently reuses the old boot_params.screen_info,
> but if drivers have change the hardware state, boot_param.screen_info
> could contain invalid info.
>
> For example, the video type might be no longer VGA, or the frame buffer
> address might be changed. If the kexec kernel keeps using the old screen_info,
> kexec'ed kernel may attempt to write to an invalid framebuffer
> memory region.
>
> There are two screen_info instances globally available, boot_params.screen_info
> and screen_info. Later one is a copy, and is updated by drivers.
>  
>  	/* Copying screen_info will do? */
> -	memcpy(&params->screen_info, &boot_params.screen_info,
> -				sizeof(struct screen_info));
> +	memcpy(&params->screen_info, &screen_info, sizeof(struct screen_info));

Well, that's better than what we had before, but how is this correct
vs. the following sequence:

    kexec_load()
    change_screen()
    kexec()

Hmm?

Thanks,

        tglx
