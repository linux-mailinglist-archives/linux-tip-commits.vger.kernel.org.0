Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2177133F995
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 20:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbhCQTzR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 15:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbhCQTyy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 15:54:54 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD4EC06174A;
        Wed, 17 Mar 2021 12:54:54 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso2049158wmi.0;
        Wed, 17 Mar 2021 12:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=scVZEoQst6gY9XYErRxOo2D348FMWQF9KFFYCoS/wjM=;
        b=sLAFHXIxxcAvhDrVwfjb1W2K+qCyYROgKbDg+Lh2Z2lvfm3ACQZH5oKvjboDKQBIOQ
         GhTBWyj+2QMkW4UQh5xhOaQpPlI2MzpU+oecIiWPM3QtFrV2o5ppp1GjMmVLXQNwAH3A
         anC8chTojKoC622Bn/Fn6N6Un6vHXj3DKb0yAu20fYjIM2atCgniXVt9WkbNgsxz8NKN
         Tus/+smXvI4SIQzpOt3RBg1sZCReI+uAFGDzuu1LOHzg4gNFTO6k8PMnMft1yeO7veH+
         1NDmXm6cM7h/PT0bMu4kOR8WtaclhqsBEHVLRSw6Nx1wJ1u20Bczxt7N+xZ1jlZXFYTf
         Qylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=scVZEoQst6gY9XYErRxOo2D348FMWQF9KFFYCoS/wjM=;
        b=jrJvYOvoec6F1ZuNX98iGHxlJd8TWZNm0RmQetSaBD2edMGCCSFujrf1MvQLX7R6Q0
         6aF/PD7crpZLdeMiFb3CVTPPep0V9cyb06v1+8dElOEnoZ+/u9xyQ3CyIawmHCtEKPjq
         YFxMOqQp8sQiqLGVsVQX3PpAS9W94KmoI1Um6omJgcZCsANT5fCqMH0OzaKONrBSUab8
         WNpbP2FkkcZFTgNBqhwrefvCJvyxkWuHGwzugLsZLSZHMQ3Bif/nmHic53l4cpzoASOz
         anl/dtnHpBEVBrl+K2emYf0F0CHmkFei0D1RSto5NB8yUOzszbf+8cPdpbSamu+s+cT3
         J+OQ==
X-Gm-Message-State: AOAM532PwMH1ueYV9GfMSDp0DRpRu8H7KAn+PtoS9NT001bntysYlyPj
        S7HCtdV/Lulakt9+mZKi748=
X-Google-Smtp-Source: ABdhPJxBFZ429tKCOUz47tGiVOK9+zUMzuz7N85RkUXRdaDwDDJ3jf0+xJEQLOdLA6aJ5uLNIkZDYA==
X-Received: by 2002:a05:600c:4ed1:: with SMTP id g17mr404824wmq.67.1616010892936;
        Wed, 17 Mar 2021 12:54:52 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id p18sm6390504wrs.68.2021.03.17.12.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 12:54:52 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 17 Mar 2021 20:54:50 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     tip-bot2 for Nicholas Piggin <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [tip: sched/core] sched/wait_bit, mm/filemap: Increase page and
 bit waitqueue hash size
Message-ID: <20210317195450.GA811242@gmail.com>
References: <20210317075427.587806-1-npiggin@gmail.com>
 <161598470782.398.7078277215554525953.tip-bot2@tip-bot2>
 <87v99pyfmp.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v99pyfmp.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Wed, Mar 17 2021 at 12:38, tip-bot wrote:
> > The following commit has been merged into the sched/core branch of tip:
> >
> > Commit-ID:     873d7c4c6a920d43ff82e44121e54053d4edba93
> > Gitweb:        https://git.kernel.org/tip/873d7c4c6a920d43ff82e44121e54053d4edba93
> > Author:        Nicholas Piggin <npiggin@gmail.com>
> > AuthorDate:    Wed, 17 Mar 2021 17:54:27 +10:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Wed, 17 Mar 2021 09:32:30 +01:00
> 
> Groan. This does not even compile and Nicholas already sent a V3 in the
> very same thread. Zapped ...

Yeah, thanks - got that too late and got distracted, groan #2.

Thanks!

	Ingo
